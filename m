From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 29 Jan 2013 18:31:14 -0600
Subject: [PATCH v2 4/4] irqchip: gic: Perform the gic_secondary_init()
 call via CPU notifier
In-Reply-To: <1359476319-23720-5-git-send-email-catalin.marinas@arm.com>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <1359476319-23720-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <1359505874.26273.14.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalina,

On Tue, 2013-01-29 at 16:18 +0000, Catalin Marinas wrote:
> All the calls to gic_secondary_init() pass 0 as the first argument.
> Since this function is called on each CPU when starting, it can be done
> in a platform-independent way via a CPU notifier registered by the GIC
> code.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-exynos/platsmp.c       |  8 --------
>  arch/arm/mach-highbank/platsmp.c     |  7 -------
>  arch/arm/mach-imx/platsmp.c          | 12 ------------
>  arch/arm/mach-msm/platsmp.c          |  8 --------
>  arch/arm/mach-omap2/omap-smp.c       |  7 -------
>  arch/arm/mach-shmobile/smp-emev2.c   |  7 -------
>  arch/arm/mach-shmobile/smp-r8a7779.c |  7 -------
>  arch/arm/mach-shmobile/smp-sh73a0.c  |  7 -------
>  arch/arm/mach-socfpga/platsmp.c      | 12 ------------
>  arch/arm/mach-spear13xx/platsmp.c    |  8 --------
>  arch/arm/mach-tegra/platsmp.c        |  8 --------
>  arch/arm/mach-ux500/platsmp.c        |  8 --------
>  arch/arm/plat-versatile/platsmp.c    |  8 --------
>  drivers/irqchip/irq-gic.c            | 28 +++++++++++++++++++++-------
>  include/linux/irqchip/arm-gic.h      |  1 -
>  15 files changed, 21 insertions(+), 115 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index a083e05..a0e8ff7 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -20,7 +20,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/smp.h>
>  

For mach-socfpga:

Tested-by: Dinh Nguyen <dinguyen@altera.com>

Thanks,
Dinh
