From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 28 Jun 2012 12:57:20 +0200
Subject: [PATCH] ARM: imx: fix i.MX35 CPU architecture
In-Reply-To: <147037481.185152.1340828906821.JavaMail.root@advansee.com>
References: <147037481.185152.1340828906821.JavaMail.root@advansee.com>
Message-ID: <20120628105720.GA21278@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 10:28:26PM +0200, Beno?t Th?baudeau wrote:
> The data sheet of the i.MX35 says it is an ARM1136JF-S processor, version r1p3,
> which, according to section "B.1. New instructions" of the ARM1136JF-S and
> ARM1136J-S Technical Reference Manual, makes the i.MX35 CPU architecture not
> only ARMv6, but ARMv6k.

Is this true for i.MX31 aswell? If not, we would have to add additional
magic to enable CPU_V6K only when SOC_IMX31 is not selected.

Sascha

> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../arch/arm/mach-imx/Kconfig                      |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/Kconfig linux-next-HEAD-49289f3/arch/arm/mach-imx/Kconfig
> index eff4db5..0345e85 100644
> --- linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/Kconfig
> +++ linux-next-HEAD-49289f3/arch/arm/mach-imx/Kconfig
> @@ -73,7 +73,7 @@ config SOC_IMX31
>  
>  config SOC_IMX35
>  	bool
> -	select CPU_V6
> +	select CPU_V6K
>  	select ARCH_MXC_IOMUX_V3
>  	select COMMON_CLK
>  	select HAVE_EPIT
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
