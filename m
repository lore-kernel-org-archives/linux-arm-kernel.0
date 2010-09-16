From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 16 Sep 2010 10:51:06 +0900
Subject: [PATCH 0/3] Common struct clk implementation, v7
In-Reply-To: <1284530924.3350.7.camel@pororo>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<20100915055320.GB23518@game.jcrosoft.org>
	<1284530924.3350.7.camel@pororo>
Message-ID: <20100916015105.GC7266@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 15, 2010 at 02:08:44PM +0800, Jeremy Kerr wrote:
> sh folks: to avoid fragmenting the discussion and filling up everyone's
> inbox I'll refrain from re-posting this series. Patches are here if
> you're interested:
> 
> http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=shortlog;h=refs/heads/clk-common
> 
I've been passively monitoring these patches as they were going by on
l-k, so there aren't really any surprises here. We'll need to do a bit of
refactoring to start using it once it is merged, but that shouldn't be
too problematic.

Right now we're using a shared clock framework between sh and ARM-based
SH-Mobile CPUs (drivers/sh/clk.c and include/linux/sh_clk.h), so both
should convert fairly easily at the same time.

It also doesn't seem like this really poses any problems or overlap with
Jean-Christophe's work for making the clkdev bits generic, so we should
be able to do both independently. If you haven't seen that, it's
currently pending in the ARM patch tracker:

	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6390/1
