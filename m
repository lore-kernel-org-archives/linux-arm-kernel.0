From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 31 Oct 2018 15:31:13 +0800
Subject: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
In-Reply-To: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <20181031073112.GL10386@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 09:45:04AM +0200, Frieder Schrempf wrote:
> Some SOCs in the i.MX6 family have a USB host controller that is
> only capable of the HSIC interface and has no on-board PHY.
> 
> To be able to use these controllers, we need to add "usb-nop-xceiv"
> dummy PHYs.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

@Peter, looks good to you?

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/imx6sl.dtsi  |  7 +++++++
>  arch/arm/boot/dts/imx6sx.dtsi  |  6 ++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 61d2d26..d3404d1 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -139,6 +139,16 @@
>  		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	usbphynop2: usbphynop2 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -981,6 +991,8 @@
>  				reg = <0x02184400 0x200>;
>  				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop1>;
> +				phy_type = "hsic";
>  				fsl,usbmisc = <&usbmisc 2>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> @@ -994,6 +1006,8 @@
>  				reg = <0x02184600 0x200>;
>  				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop2>;
> +				phy_type = "hsic";
>  				fsl,usbmisc = <&usbmisc 3>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 7a4f5da..81edcdc 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -110,6 +110,11 @@
>  		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -815,6 +820,8 @@
>  				reg = <0x02184400 0x200>;
>  				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SL_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop1>;
> +				phy_type = "hsic";
>  				fsl,usbmisc = <&usbmisc 2>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 844caa3..07ed417 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -159,6 +159,11 @@
>  		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -877,6 +882,7 @@
>  				reg = <0x02184400 0x200>;
>  				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SX_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop1>;
>  				fsl,usbmisc = <&usbmisc 2>;
>  				phy_type = "hsic";
>  				fsl,anatop = <&anatop>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
