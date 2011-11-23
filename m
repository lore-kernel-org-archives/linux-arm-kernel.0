From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 23 Nov 2011 12:28:55 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111123120534.GO21073@opensource.wolfsonmicro.com>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
Message-ID: <20111123122855.GB7382@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Nov 23, 2011 at 12:05:35PM +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 10:21:35PM +0000, Jamie Iles wrote:
> 
> > No, you're right - this is the offending commit.  It actually needs 
> > this[1] fix and things should be okay.
> 
> > 1. https://lkml.org/lkml/2011/11/10/186
> 
> I've tested with that patch and it doesn't seem to be the only fix
> that's required - my system still exhibits the same behaviour.

Hmm, I really can't see what could cause this - we don't have a to_irq() 
ops method, hwirq_base is correctly initialised to 0 with 32 irqs per 
VIC and we aren't using dynamic irq_desc's.

Do you have any low-level serial debug?

Thanks,

Jamie
