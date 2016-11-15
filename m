From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 Nov 2016 16:43:16 +0100
Subject: [PATCH v3 2/2] arm64: dts: rockchip: add usb2-phy otg-port
 support for rk3399
In-Reply-To: <1478520529-8869-3-git-send-email-wulf@rock-chips.com>
References: <1478520529-8869-1-git-send-email-wulf@rock-chips.com>
 <1478520529-8869-3-git-send-email-wulf@rock-chips.com>
Message-ID: <3322090.Jd0z3Op9pV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 7. November 2016, 20:08:49 CET schrieb William Wu:
> Add otg-port nodes for both u2phy0 and u2phy1. The otg-port can
> be used for USB2.0 part of USB3.0 OTG controller.
> 
> Signed-off-by: William Wu <wulf@rock-chips.com>
> ---
> Changes in v3:
> - None
> 
> Changes in v2:
> - None
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index b65c193..ea2df51 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1095,6 +1095,17 @@
>  			clock-output-names = "clk_usbphy0_480m";
>  			status = "disabled";
> 
> +			u2phy0_otg: otg-port {
> +				#phy-cells = <0>;
> +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
> +					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
> +					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
> +				interrupt-names = "otg-bvalid", "otg-id",
> +						  "linestate";
> +				status = "disabled";
> +			};
> +
> +

applied to my dts64 branch after removing that double empty line and also 
switching host and otg sub nodes to get alphabetical sorting.


Thanks
Heiko
