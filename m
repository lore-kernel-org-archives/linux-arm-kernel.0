From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Jan 2011 17:26:44 -0800
Subject: [PATCH 6/7] arm: plat-omap: system.h: move voiceblue
	definitions into the board header
In-Reply-To: <20110118092203.GA10997@n2100.arm.linux.org.uk>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
	<1295337165-22934-7-git-send-email-aaro.koskinen@iki.fi>
	<20110118092203.GA10997@n2100.arm.linux.org.uk>
Message-ID: <20110120012644.GR4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 01:23]:
> On Tue, Jan 18, 2011 at 09:52:44AM +0200, Aaro Koskinen wrote:
> > Move voiceblue definitions into the board-specific header.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Let's instead simplify this, and allow other platforms to hook into the
> reset handler if they choose.  This has only been build-tested on my
> omap1 (which includes voiceblue) and omap4 configurations.
> 
> 8<------
> Subject: ARM: OMAP: Allow platforms to hook reset cleanly
> 
> This adds a clean method to allow platforms to hook into the reset
> code if they require to.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-omap1/Makefile             |    2
>  arch/arm/mach-omap1/board-voiceblue.c    |  106 +++++++++++++++++--------------
>  arch/arm/mach-omap1/reset.c              |   25 +++++++
>  arch/arm/mach-omap2/prcm.c               |    5 +
>  arch/arm/plat-omap/include/plat/prcm.h   |    1
>  arch/arm/plat-omap/include/plat/system.h |   38 -----------
>  6 files changed, 91 insertions(+), 86 deletions(-)

Looks good to me. I'll queue all these into devel-cleanup
branch for the next merge window.

Regards,

Tony
