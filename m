From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Dec 2009 18:13:29 -0800
Subject: [PATCH 1/9] omap: use smc91x_platdata to setup smc91x
In-Reply-To: <20091209004958.5944.81769.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
	<20091209004958.5944.81769.stgit@localhost>
Message-ID: <20091209021329.GK24013@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091208 16:48]:
> From: Ladislav Michl <ladis@linux-mips.org>
> 
> Use smc91x_platdata to setup smc91x, so we can get rid of OMAP specific stuff
> in smc91x driver
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/board-fsample.c   |   10 ++++++++++
>  arch/arm/mach-omap1/board-h2.c        |   10 ++++++++++
>  arch/arm/mach-omap1/board-h3.c        |   10 ++++++++++
>  arch/arm/mach-omap1/board-innovator.c |   13 +++++++++++++
>  arch/arm/mach-omap1/board-osk.c       |   10 ++++++++++
>  arch/arm/mach-omap1/board-perseus2.c  |   10 ++++++++++
>  arch/arm/mach-omap1/board-voiceblue.c |   10 ++++++++++
>  arch/arm/mach-omap2/board-apollon.c   |   10 ++++++++++
>  arch/arm/mach-omap2/gpmc-smc91x.c     |    8 +++++---
>  arch/arm/plat-omap/debug-devices.c    |   10 ++++++++++
>  10 files changed, 98 insertions(+), 3 deletions(-)

Looks like this needs a minor change to build for innovator 1610.
Will merge in the following fix as otherwise the smc91x_platdata
is not defined for 1610.

Tony
