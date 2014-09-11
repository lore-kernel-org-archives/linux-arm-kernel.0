From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Sep 2014 14:08:01 -0700
Subject: [PATCH 30/35] irqchip: add irq-omap-intc.h header
In-Reply-To: <1406582183-696-31-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-31-git-send-email-balbi@ti.com>
Message-ID: <20140911210800.GI18849@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140728 14:19]:
> OMAP INTC irqchip driver will be moved under
> drivers/irqchip/ soon but we still have a dependency
> with mach-omap2 when it comes to idle functions.
> 
> In order to make it easy to share those function
> prototypes with OMAP PM code, we introduce this new
> header.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c        |  1 +
>  arch/arm/mach-omap2/board-am3517crane.c    |  1 +
>  arch/arm/mach-omap2/board-am3517evm.c      |  1 +
>  arch/arm/mach-omap2/board-cm-t35.c         |  1 +
>  arch/arm/mach-omap2/board-cm-t3517.c       |  1 +
>  arch/arm/mach-omap2/board-devkit8000.c     |  1 +
>  arch/arm/mach-omap2/board-ldp.c            |  1 +
>  arch/arm/mach-omap2/board-omap3beagle.c    |  1 +
>  arch/arm/mach-omap2/board-omap3logic.c     |  1 +
>  arch/arm/mach-omap2/board-omap3pandora.c   |  1 +
>  arch/arm/mach-omap2/board-omap3stalker.c   |  1 +
>  arch/arm/mach-omap2/board-omap3touchbook.c |  1 +
>  arch/arm/mach-omap2/board-overo.c          |  1 +
>  arch/arm/mach-omap2/board-rx51.c           |  1 +
>  arch/arm/mach-omap2/board-ti8168evm.c      |  1 +
>  arch/arm/mach-omap2/common.h               |  9 ---------
>  arch/arm/mach-omap2/cpuidle34xx.c          |  1 +
>  arch/arm/mach-omap2/irq.c                  |  1 +
>  arch/arm/mach-omap2/pm24xx.c               |  1 +
>  arch/arm/mach-omap2/pm34xx.c               |  1 +
>  include/linux/irqchip/irq-omap-intc.h      | 32 ++++++++++++++++++++++++++++++
>  21 files changed, 51 insertions(+), 9 deletions(-)

I ended up setting up another branch without this patch
at omap-for-v3.12/intc-v2. It now has dependency to the
SoC changes from Nishant and the const cleanup fix from Uwe.

This patch is not needed, let's leave this out, the functions
needed by the platform code won't need to be in a separate
header file as they are only needed by the platform code.

If you have a chance, can you please repost the remainging
patches to do the actual move to drivers, but without this
patch? And if we are lucky we'll get an ack from the
drivers/irqchip maintainers and I can apply those changes too
into omap-for-v3.12/intc-v2 ;)

Regards,

Tony
