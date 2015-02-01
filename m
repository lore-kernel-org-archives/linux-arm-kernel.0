From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Feb 2015 15:17:50 +0100
Subject: [PATCH v3 06/10] ARM: dts: sun9i: Add USB host controller nodes
 to a80 dtsi
In-Reply-To: <1422388455-25923-7-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
 <1422388455-25923-7-git-send-email-wens@csie.org>
Message-ID: <20150201141750.GG4827@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 03:54:11AM +0800, Chen-Yu Tsai wrote:
> The A80 has 3 EHCI/OHCI USB controllers.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 70 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index d7ebd9390b01..9483b15bfda7 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -355,6 +355,28 @@
>  		 */
>  		ranges = <0 0 0 0x20000000>;
>  
> +		ehci0: usb at 00a00000 {
> +			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
> +			reg = <0x00a00000 0x100>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&usb_mod_clk 1>;
> +			resets = <&usb_mod_clk 17>;
> +			phys = <&usbphy1>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		ohci0: usb at 00a00400 {
> +			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
> +			reg = <0x00a00400 0x100>;
> +			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&usb_mod_clk 1>, <&usb_mod_clk 2>;
> +			resets = <&usb_mod_clk 17>;
> +			phys = <&usbphy1>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
>  		usbphy1: phy at 00a00800 {
>  			compatible = "allwinner,sun9i-a80-usb-phy";
>  			reg = <0x00a00800 0x4>;
> @@ -366,6 +388,32 @@
>  			#phy-cells = <0>;
>  		};
>  
> +		ehci1: usb at 00a01000 {
> +			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
> +			reg = <0x00a01000 0x100>;
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&usb_mod_clk 3>;
> +			resets = <&usb_mod_clk 18>;
> +			phys = <&usbphy2>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		/*
> +		 * Even though ohci1 exists, it is never used as
> +		 * usb1 only has HSIC pins routed externally
> +		 */
> +		ohci1: usb at 00a01400 {
> +			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
> +			reg = <0x00a01400 0x100>;
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&usb_mod_clk 3>, <&usb_mod_clk 4>;
> +			resets = <&usb_mod_clk 18>;
> +			phys = <&usbphy2>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +

Is it worth declaring it then? If it's not never ever going to be used
since no pins are routed outside of the SoC, I don't think it should
be declared in the DTSI.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150201/c5fc7bf1/attachment.sig>
