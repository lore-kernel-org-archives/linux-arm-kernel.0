From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 13:50:34 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111123133237.GC7382@totoro>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111123120534.GO21073@opensource.wolfsonmicro.com>
 <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
Message-ID: <20111123135033.GA20272@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 01:32:37PM +0000, Jamie Iles wrote:
> On Wed, Nov 23, 2011 at 01:01:35PM +0000, Mark Brown wrote:

> > I tried adding some yesterday around the VIC registration in the CPU
> > code but it didn't actually appear on the console so I'm none the wiser.

> OK.  You mentioned you had trouble reverting the patch yesterday - I've 
> pushed a branch (git://github.com/jamieiles/linux-2.6-ji.git 
> vic-dt-revert-next) which is today's next with all of the VIC patches 
> reverted if you want to try that to be sure.  I've built s3c6400_defconfig 
> successfully, but can't test it unless there's a qemu model somewhere?

It wasn't the mechanics of reverting that caused problems, it was the
fact that when I reverted things still didn't work.  Actually, I've gone
back and retested with the for-next branch from today and it appears
that for some reason the issue has gone away there which is a bit
confusing though as I write this it occurs to me that I did turn device
tree back on (my board doesn't use it but I typically build it in) which
I had off when I tested yesterday and would explain the issue.

It looks like there's a second bug breaking the boot in there - testing
your commit the board boots but if I test the tip of Russell's for-next
then that breaks again.  I'm just starting another bisect and
considering sending a patch to add a git finger-point alias.
