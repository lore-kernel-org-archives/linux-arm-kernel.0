From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Mar 2014 18:12:49 +0530
Subject: [PATCH v5 6/6] arm/dts: added dt properties to adapt to the new
 phy framwork
In-Reply-To: <1393846695-14644-7-git-send-email-kishon@ti.com>
References: <1393846695-14644-1-git-send-email-kishon@ti.com>
 <1393846695-14644-7-git-send-email-kishon@ti.com>
Message-ID: <53171BC9.8050808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony/Benoit,

On Monday 03 March 2014 05:08 PM, Kishon Vijay Abraham I wrote:
> Added device tree bindings for dwc3, usb2 and usb3 PHYs. The documentation
> of these can be found at Documentation/devicetree/bindings/phy/phy-bindings.txt
> and Documentation/devicetree/bindings/phy/ti-phy.txt.

Can this patch be queued for 3.15 merge window?

Thanks
Kishon

>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a72813a..1c68558 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -732,7 +732,8 @@
>   				compatible = "snps,dwc3";
>   				reg = <0x4a030000 0x10000>;
>   				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -				usb-phy = <&usb2_phy>, <&usb3_phy>;
> +				phys = <&usb2_phy>, <&usb3_phy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>   				dr_mode = "peripheral";
>   				tx-fifo-resize;
>   			};
> @@ -749,6 +750,7 @@
>   				compatible = "ti,omap-usb2";
>   				reg = <0x4a084000 0x7c>;
>   				ctrl-module = <&omap_control_usb2phy>;
> +				#phy-cells = <0>;
>   			};
>
>   			usb3_phy: usb3phy at 4a084400 {
> @@ -758,6 +760,7 @@
>   				      <0x4a084c00 0x40>;
>   				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>   				ctrl-module = <&omap_control_usb3phy>;
> +				#phy-cells = <0>;
>   			};
>   		};
>
>
