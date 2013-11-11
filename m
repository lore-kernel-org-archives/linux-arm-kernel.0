From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Nov 2013 16:11:50 +0800
Subject: [PATCH 1/5] ARM: dts: i.MX51: Move usbphy0 node from AIPS1
In-Reply-To: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
References: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131111081148.GA11083@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 12:45:04PM +0400, Alexander Shiyan wrote:
> usbphy0 is not a part of AIPS1, so move this node under usbotg.
> Additionally this patch removes useless "status" property.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied all except #4.  I would add those pingroups only when there are
in-tree users of it.

Shawn

> ---
>  arch/arm/boot/dts/imx51.dtsi | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 463dfe8..1075a7d 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -189,13 +189,6 @@
>  				};
>  			};
>  
> -			usbphy0: usbphy at 0 {
> -				compatible = "usb-nop-xceiv";
> -				clocks = <&clks 75>;
> -				clock-names = "main_clk";
> -				status = "okay";
> -			};
> -
>  			usbotg: usb at 73f80000 {
>  				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
>  				reg = <0x73f80000 0x0200>;
> @@ -204,6 +197,12 @@
>  				fsl,usbmisc = <&usbmisc 0>;
>  				fsl,usbphy = <&usbphy0>;
>  				status = "disabled";
> +
> +				usbphy0: usbphy at 0 {
> +					compatible = "usb-nop-xceiv";
> +					clocks = <&clks 75>;
> +					clock-names = "main_clk";
> +				};
>  			};
>  
>  			usbh1: usb at 73f80200 {
> -- 
> 1.8.1.5
> 
