From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 12 Jan 2018 18:28:22 +1100
Subject: [PATCH 1/2] dts: ARM: Aspeed-g5: Add missing USB clock and pinmux
In-Reply-To: <1515736921.31850.92.camel@kernel.crashing.org>
References: <1515736921.31850.92.camel@kernel.crashing.org>
Message-ID: <1515742102.31850.105.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-01-12 at 17:02 +1100, Benjamin Herrenschmidt wrote:
> This adds the clock and pinmux default references to
> the Aspeed G5 SoC base device-tree for USB. The clk and
> pinmux drivers already know about these.

Drop this. It depends on a patch you don't have. I'll send a v2

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 8b3986a941f5..3c5c9b952ba8 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -142,6 +142,7 @@
>  			compatible = "aspeed,ast2500-ehci", "generic-ehci";
>  			reg = <0x1e6a1000 0x100>;
>  			interrupts = <5>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
>  			status = "disabled";
>  		};
>  
> @@ -149,6 +150,7 @@
>  			compatible = "aspeed,ast2500-ehci", "generic-ehci";
>  			reg = <0x1e6a3000 0x100>;
>  			interrupts = <13>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
>  			status = "disabled";
>  		};
>  
> @@ -157,6 +159,7 @@
>  			reg = <0x1e6b0000 0x100>;
>  			interrupts = <14>;
>  			#ports = <2>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
>  			status = "disabled";
>  		};
>  
> @@ -1387,6 +1390,21 @@
>  		groups = "USBCKI";
>  	};
>  
> +	pinctrl_usb2ah_default: usb2ah_default {
> +		function = "USB2AH";
> +		groups = "USB2AH";
> +	};
> +
> +	pinctrl_usb11bhid_default: usb11bhid_default {
> +		function = "USB11BHID";
> +		groups = "USB11BHID";
> +	};
> +
> +	pinctrl_usb2bh_default: usb2bh_default {
> +		function = "USB2BH";
> +		groups = "USB2BH";
> +	};
> +
>  	pinctrl_vgabiosrom_default: vgabiosrom_default {
>  		function = "VGABIOSROM";
>  		groups = "VGABIOSROM";
