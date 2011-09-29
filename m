From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Sep 2011 21:12:31 +0800
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20110929125026.GJ23944@n2100.arm.linux.org.uk>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
	<20110929092828.GE19318@S2100-06.ap.freescale.net>
	<20110929092406.GD23944@n2100.arm.linux.org.uk>
	<20110929124419.GF19318@S2100-06.ap.freescale.net>
	<20110929125026.GJ23944@n2100.arm.linux.org.uk>
Message-ID: <20110929131229.GG19318@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 01:50:26PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 29, 2011 at 08:44:20PM +0800, Shawn Guo wrote:
> > Yeah, that's why I want to get imx6q stay away from this infrastructure
> > right now.  I do not see any simplicity and cleanup on imx6q current
> > code by migrating to this infrastructure.
> 
> Why?  If the data is already saved for you, then there's no reason not
> to use it.  The fact that some generic code doesn't give you _exactly_
> everything you'd want is not a reason to avoid it.
> 
> The cleanup for imx6q is that it would no longer have to have its own
> distinct code for saving the register values - and that's a danmed good
> thing.
> 
It cleans up the register saving but requires additional code handling
physical address of l2x0_saved_regs.

> The idea here is that we consolidate what _can_ be consolidated (which
> is the register saving.)
> 
> If you feel soo strongly that it's not worth doing, then let's stop
> wasting time and review effort on this, and instead have _every_ SoC
> implementing their own private L2 cache handling on resume.
> 
This infrastructure is definitely good thing for platform that L2 will
be lost during suspend.  But for imx6q which retains L2, I would not
migrate it until the physical base of L2 and l2x0_saved_regs itself can
be retrieved from infrastructure too.

-- 
Regards,
Shawn
