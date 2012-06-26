From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 26 Jun 2012 11:04:18 +0200
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
In-Reply-To: <1338084709-12043-1-git-send-email-marex@denx.de>
References: <1338084709-12043-1-git-send-email-marex@denx.de>
Message-ID: <4FE97B12.8040306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2012 04:11 AM, Marek Vasut wrote:
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

This compiles in the code to create a flexcan platform device, which
should not be needed in the DT case. You save some bytes if you use:

+       select HAVE_CAN_FLEXCAN if NET && CAN

>  
>  comment "MXS platforms:"
>  

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/fc2a62f9/attachment.sig>
