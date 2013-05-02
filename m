From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 May 2013 16:32:49 -0700
Subject: [PATCH 7/9] ARM: OMAP: don't select SERIAL_OMAP unconditionally
In-Reply-To: <1367528578-518090-8-git-send-email-arnd@arndb.de>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1367528578-518090-8-git-send-email-arnd@arndb.de>
Message-ID: <20130502233249.GU28721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130502 14:08]:
> It is possible to build a kernel without TTY support, so we must not
> attempt to select SERIAL_OMAP in that case.
> 
> warning: (ARCH_OMAP2PLUS_TYPICAL) selects SERIAL_OMAP which has unmet direct dependencies (TTY && HAS_IOMEM && GENERIC_HARDIRQS && ARCH_OMAP2PLUS)
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap2/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 857b1f0..a95c7af 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -37,8 +37,8 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
>  	select PM_RUNTIME
>  	select REGULATOR
> -	select SERIAL_OMAP
> -	select SERIAL_OMAP_CONSOLE
> +	select SERIAL_OMAP if TTY
> +	select SERIAL_OMAP_CONSOLE if TTY
>  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
>  	select VFP

Please just drop this and pick my earlier fix instead:

[PATCH 1/3] ARM: OMAP2+: Fix unmet direct dependencies for SERIAL_OMAP

Or let me know if you prefer me to queue it.

Regards,

Tony
