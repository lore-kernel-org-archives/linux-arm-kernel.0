From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 23 Nov 2011 13:32:37 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111123130134.GB12227@opensource.wolfsonmicro.com>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
 <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
Message-ID: <20111123133237.GC7382@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Nov 23, 2011 at 01:01:35PM +0000, Mark Brown wrote:
> On Wed, Nov 23, 2011 at 12:28:55PM +0000, Jamie Iles wrote:
> 
> > Hmm, I really can't see what could cause this - we don't have a to_irq() 
> > ops method, hwirq_base is correctly initialised to 0 with 32 irqs per 
> > VIC and we aren't using dynamic irq_desc's.
> 
> Are you sure the numbers come out the same as they would otherwise.

Yes, I've just tried a little bit of test code (I don't have a non-DT 
VIC platform) but for each IRQ (starting from 32 like your platform) for 
2 VIC's it just sets the hwirq (0->31 for each VIC) for each IRQ and 
that's all the IRQ domain stuff does for non-DT platforms.

> > Do you have any low-level serial debug?
> 
> I tried adding some yesterday around the VIC registration in the CPU
> code but it didn't actually appear on the console so I'm none the wiser.

OK.  You mentioned you had trouble reverting the patch yesterday - I've 
pushed a branch (git://github.com/jamieiles/linux-2.6-ji.git 
vic-dt-revert-next) which is today's next with all of the VIC patches 
reverted if you want to try that to be sure.  I've built s3c6400_defconfig 
successfully, but can't test it unless there's a qemu model somewhere?

Thanks,

Jamie
