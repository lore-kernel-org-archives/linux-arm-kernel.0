From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Nov 2014 20:38:02 +0100
Subject: [PATCH v8 12/13] ARM: dts: berlin: add BG2CD nodes for USB support
In-Reply-To: <1416231347-27193-13-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231347-27193-1-git-send-email-antoine.tenart@free-electrons.com>
 <1416231347-27193-13-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <546BA01A.6050707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2014 14:35, Antoine Tenart wrote:
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> Adds nodes describing the Marvell Berlin BG2CD USB PHY and USB. The BG2CD
> SoC has 2 USB ChipIdea controllers, with usb0 host-only and usb1 dual-role
> capable.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied to berlin/dt with usb-phy nodes reordered correctly (ethernet
nodes came in between in the meantime).

Thanks!

> ---
>   arch/arm/boot/dts/berlin2cd.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> index 68f7032b4686..af5e628547ce 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -66,6 +66,22 @@
>   			clocks = <&chip CLKID_TWD>;
>   		};
>
> +		usb_phy0: usb-phy at b74000 {
> +			compatible = "marvell,berlin2cd-usb-phy";
> +			reg = <0xb74000 0x128>;
> +			#phy-cells = <0>;
> +			resets = <&chip 0x178 23>;
> +			status = "disabled";
> +		};
> +
> +		usb_phy1: usb-phy at b78000 {
> +			compatible = "marvell,berlin2cd-usb-phy";
> +			reg = <0xb78000 0x128>;
> +			#phy-cells = <0>;
> +			resets = <&chip 0x178 24>;
> +			status = "disabled";
> +		};
> +
>   		apb at e80000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
> @@ -242,6 +258,26 @@
>   			};
>   		};
>
> +		usb0: usb at ed0000 {
> +			compatible = "chipidea,usb2";
> +			reg = <0xed0000 0x200>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&chip CLKID_USB0>;
> +			phys = <&usb_phy0>;
> +			phy-names = "usb-phy";
> +			status = "disabled";
> +		};
> +
> +		usb1: usb at ee0000 {
> +			compatible = "chipidea,usb2";
> +			reg = <0xee0000 0x200>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&chip CLKID_USB1>;
> +			phys = <&usb_phy1>;
> +			phy-names = "usb-phy";
> +			status = "disabled";
> +		};
> +
>   		apb at fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
>
