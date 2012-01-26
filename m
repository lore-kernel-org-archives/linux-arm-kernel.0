From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jan 2012 20:31:18 +0000
Subject: [PATCH] Added phy3250_defconfig
In-Reply-To: <1327592865-16859-1-git-send-email-stigge@antcom.de>
References: <1327592865-16859-1-git-send-email-stigge@antcom.de>
Message-ID: <20120126203118.GC11941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 04:47:45PM +0100, Roland Stigge wrote:
> diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
> index 369b152..6b9b3e0 100644
> --- a/arch/arm/mach-lpc32xx/common.c
> +++ b/arch/arm/mach-lpc32xx/common.c
> @@ -164,7 +164,7 @@ int clk_is_sysclk_mainosc(void)
>  /*
>   * System reset via the watchdog timer
>   */
> -static void lpc32xx_watchdog_reset(void)
> +void lpc32xx_watchdog_reset(void)

That's a build fix, and so should be a separate patch from other changes.

>  {
>  	/* Make sure WDT clocks are enabled */
>  	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index bfee5b4..f4ea653 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -381,7 +381,7 @@ static int __init lpc32xx_display_uid(void)
>  }
>  arch_initcall(lpc32xx_display_uid);
>  
> -MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
> +MACHINE_START(LPC3XXX, "Phytec 3250 board with the LPC3250 Microcontroller")

This looks wrong.  Please explain this change; the ID is supposed to be
the board number, not related to the SoC.  As this is for the phytec 3250
board, the original looks more correct to me.

Plus, changing this potentially breaks working setups which are using the
PHY3250 ID.
