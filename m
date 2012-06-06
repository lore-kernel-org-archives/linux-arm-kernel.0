From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Jun 2012 13:39:57 +0800
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
In-Reply-To: <1338084709-12043-1-git-send-email-marex@denx.de>
References: <1338084709-12043-1-git-send-email-marex@denx.de>
Message-ID: <20120606053955.GE2667@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 27, 2012 at 04:11:49AM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  arch/arm/boot/dts/imx28.dtsi |    2 ++
>  arch/arm/mach-mxs/Kconfig    |    1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 119f183..13c6084 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -278,12 +278,14 @@
>  			};
>  
>  			can0: can at 80032000 {
> +				compatible = "fsl,p1010-flexcan";
>  				reg = <0x80032000 2000>;
>  				interrupts = <8>;
>  				status = "disabled";
>  			};
>  
>  			can1: can at 80034000 {
> +				compatible = "fsl,p1010-flexcan";
>  				reg = <0x80034000 2000>;
>  				interrupts = <9>;
>  				status = "disabled";
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 91cf062..0406f37 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -18,6 +18,7 @@ config SOC_IMX28
>  	select CPU_ARM926T
>  	select HAVE_PWM
>  	select PINCTRL_IMX28
> +	select MXS_HAVE_PLATFORM_FLEXCAN

This change shouldn't be part of this patch.  Furthermore, this symbol
and arch/arm/mach-mxs/devices/platform-flexcan.c should be removed
completely after we covert all these board files that have flexcan
device enabled over to DT.

Regards,
Shawn

>  
>  comment "MXS platforms:"
>  
> -- 
> 1.7.10
> 
