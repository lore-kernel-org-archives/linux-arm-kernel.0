From: rogerq@ti.com (Roger Quadros)
Date: Thu, 12 Sep 2013 16:28:41 +0300
Subject: [PATCH 6/7] arm/dts: added dt properties to adapt to the new
 phy framwork
In-Reply-To: <1378136591-7463-7-git-send-email-kishon@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-7-git-send-email-kishon@ti.com>
Message-ID: <5231C189.2040406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Need some commit log.

cheers,
-roger

On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 94abef5..9fe71ff 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -651,7 +651,8 @@
>  				compatible = "snps,dwc3";
>  				reg = <0x4a030000 0x10000>;
>  				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -				usb-phy = <&usb2_phy>, <&usb3_phy>;
> +				phys = <&usb2_phy>, <&usb3_phy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>  				tx-fifo-resize;
>  			};
>  		};
> @@ -667,6 +668,7 @@
>  				compatible = "ti,omap-usb2";
>  				reg = <0x4a084000 0x7c>;
>  				ctrl-module = <&omap_control_usb2phy>;
> +				#phy-cells = <0>;
>  			};
>  
>  			usb3_phy: usb3phy at 4a084400 {
> @@ -676,6 +678,7 @@
>  				      <0x4a084c00 0x40>;
>  				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>  				ctrl-module = <&omap_control_usb3phy>;
> +				#phy-cells = <0>;
>  			};
>  		};
>  
> 
