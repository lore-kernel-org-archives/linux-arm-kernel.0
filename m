From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Mar 2014 13:03:24 +0800
Subject: [PATCH 6/9] ARM: dts: i.MX35: Add USB support.
In-Reply-To: <1394211863-7569-6-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <1394211863-7569-6-git-send-email-denis@eukrea.com>
Message-ID: <20140310050322.GC15218@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 06:04:20PM +0100, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx35.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> index e59ccb4..1c15b56 100644
> --- a/arch/arm/boot/dts/imx35.dtsi
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -292,6 +292,15 @@
>  				status = "disabled";
>  			};
>  
> +			usbphy0: usbphy at 0 {
> +				compatible = "usb-nop-xceiv";
> +			};
> +
> +			usbphy1: usbphy at 1 {
> +				compatible = "usb-nop-xceiv";
> +			};
> +
> +

Can we put these (also imx25.dtsi) in the same way that imx51.dtsi
organizes it?

Shawn

>  			usbotg: usb at 53ff4000 {
>  				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
>  				reg = <0x53ff4000 0x0200>;
> @@ -299,6 +308,7 @@
>  				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
>  				clock-names = "ipg", "ahb", "per";
>  				fsl,usbmisc = <&usbmisc 0>;
> +				fsl,usbphy = <&usbphy0>;
>  				status = "disabled";
>  			};
>  
> @@ -309,6 +319,7 @@
>  				clocks = <&clks 9>, <&clks 73>, <&clks 28>;
>  				clock-names = "ipg", "ahb", "per";
>  				fsl,usbmisc = <&usbmisc 1>;
> +				fsl,usbphy = <&usbphy1>;
>  				status = "disabled";
>  			};
>  
> -- 
> 1.7.9.5
> 
