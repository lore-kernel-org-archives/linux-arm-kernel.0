From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 27 Sep 2011 11:43:52 +0800
Subject: [PATCH v2 16/16] ARM: GIC: Make MULTI_IRQ_HANDLER mandatory
In-Reply-To: <1317034955-1029-17-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110927034350.GA17997@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 12:02:35PM +0100, Marc Zyngier wrote:
> Now that MULTI_IRQ_HANDLER is selected by all the in-tree
> GIC users, make it mandatory and remove the unused macros.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/Kconfig                                |    3 -
>  arch/arm/common/Kconfig                         |    1 +
>  arch/arm/common/gic.c                           |    2 +-
>  arch/arm/include/asm/hardware/entry-macro-gic.S |   60 -----------------------
>  arch/arm/include/asm/hardware/gic.h             |    1 -
>  arch/arm/mach-msm/Kconfig                       |    2 -
>  arch/arm/mach-omap2/Kconfig                     |    1 +
>  arch/arm/mach-tegra/Kconfig                     |    1 -
>  arch/arm/mach-ux500/Kconfig                     |    1 -
>  arch/arm/plat-omap/Kconfig                      |    1 -
>  10 files changed, 3 insertions(+), 70 deletions(-)
>  delete mode 100644 arch/arm/include/asm/hardware/entry-macro-gic.S
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0514264..d3e246c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -334,7 +334,6 @@ config ARCH_CNS3XXX
>  	select ARM_GIC
>  	select MIGHT_HAVE_PCI
>  	select PCI_DOMAINS if PCI
> -	select MULTI_IRQ_HANDLER
>  	help
>  	  Support for Cavium Networks CNS3XXX platform.
>  
> @@ -788,7 +787,6 @@ config ARCH_EXYNOS4
>  	select HAVE_S3C_RTC if RTC_CLASS
>  	select HAVE_S3C2410_I2C if I2C
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
> -	select MULTI_IRQ_HANDLER
>  	help
>  	  Samsung EXYNOS4 series based systems
>  
> @@ -911,7 +909,6 @@ config ARCH_ZYNQ
>  	select ARM_AMBA
>  	select ICST
>  	select USE_OF
> -	select MULTI_IRQ_HANDLER
>  	help
>  	  Support for Xilinx Zynq ARM Cortex A9 Platform
>  endchoice

Hi Marc,

I'm unsure about your base.  But I have the following platforms in
arch/arm/Kconfig selecting MULTI_IRQ_HANDLER at the end of your series,
which should also be removed from?

  ARCH_REALVIEW
  ARCH_VEXPRESS
  ARCH_PXA
  ARCH_SHMOBILE

-- 
Regards,
Shawn
