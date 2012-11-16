From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 15:15:22 +0800
Subject: [PATCH 4/4] ARM: dts: imx: add imx5x phy-mode entries
In-Reply-To: <1352988014-14769-5-git-send-email-m.grzeschik@pengutronix.de>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352988014-14769-5-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20121116071519.GE2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 03:00:14PM +0100, Michael Grzeschik wrote:
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx51.dtsi |    2 ++
>  arch/arm/boot/dts/imx53.dtsi |    2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 366b8d3..ffc6bc8 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -145,6 +145,7 @@
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80200 0x0200>;
>  				interrupts = <14>;
> +				phy-mode = "utmiw";

I tried to grep "phy-mode" and "utmiw" on linux-next and found nothing.
So it's not something we can take for 3.8, right?

PS. Instead, I found something like phy_type = "utmi_wide" in
fsl-usb.txt and fsl-mph-dr-of.c.  Should these be consolidated into
a common binding?

Shawn

>  				status = "disabled";
>  			};
>  
> @@ -152,6 +153,7 @@
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80400 0x0200>;
>  				interrupts = <16>;
> +				phy-mode = "utmi";
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 2faa193..1da8e12 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -143,6 +143,7 @@
>  				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
>  				reg = <0x53f80000 0x0200>;
>  				interrupts = <18>;
> +				phy-mode = "utmiw";
>  				status = "disabled";
>  			};
>  
> @@ -150,6 +151,7 @@
>  				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
>  				reg = <0x53f80200 0x0200>;
>  				interrupts = <14>;
> +				phy-mode = "utmi";
>  				status = "disabled";
>  			};
>  
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
