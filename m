From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 16:24:49 +0800
Subject: [PATCH v2 2/7] ARM: imx: Select GPCv2 for i.MX7
In-Reply-To: <20170418150133.31679-3-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
 <20170418150133.31679-3-andrew.smirnov@gmail.com>
Message-ID: <20170503082447.GB18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:01:28AM -0700, Andrey Smirnov wrote:
> GPCv2 IP block is a part of i.MX7 SoC. Select it to make corresponding
> driver availible to support DT changes following this patch.
> 
> Cc: yurovsky at gmail.com
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 936c59d..1a4ea3a 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -532,6 +532,7 @@ config SOC_IMX7D
>  	bool "i.MX7 Dual support"
>  	select PINCTRL_IMX7D
>  	select ARM_GIC
> +	select IMX_GPCV2

Yes, PINCTRL_IMX7D is already out of order, but still please keep new
added one sorted in alphabetic order.

Shawn

>  	select HAVE_ARM_ARCH_TIMER
>  	select HAVE_IMX_ANATOP
>  	select HAVE_IMX_MMDC
> -- 
> 2.9.3
> 
