From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 14:53:20 +0930
Subject: [PATCH 2/7] arm: dts: aspeed: Add aspeed G5 USB host pinmux
In-Reply-To: <20180629035106.27181-3-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
 <20180629035106.27181-3-benh@kernel.crashing.org>
Message-ID: <1531718600.1114140.1441828880.06F3B897@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018, at 13:21, Benjamin Herrenschmidt wrote:
> Set the default pinmux for EHCIs so boards don't have to do
> it an document why it is not set for UHCI.
> 
> Remove the properties from the AST2500 EVB board which are
> now redundant
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-ast2500-evb.dts | 6 ------
>  arch/arm/boot/dts/aspeed-g5.dtsi         | 8 ++++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/
> dts/aspeed-ast2500-evb.dts
> index ede11c597673..2bff1b253842 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -82,18 +82,12 @@
>  
>  &ehci0 {
>  	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usb2ah_default>;
>  };
>  
>  &ehci1 {
>  	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usb2bh_default>;
>  };
>  
>  &uhci {
>  	status = "okay";
> -
> -	/* No pinctrl, this follows the above EHCI settings */
>  };
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 17f2714d18a7..dfdc239b86f6 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -148,6 +148,8 @@
>  			reg = <0x1e6a1000 0x100>;
>  			interrupts = <5>;
>  			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2ah_default>;
>  			status = "disabled";
>  		};
>  
> @@ -156,6 +158,8 @@
>  			reg = <0x1e6a3000 0x100>;
>  			interrupts = <13>;
>  			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2bh_default>;
>  			status = "disabled";
>  		};
>  
> @@ -166,6 +170,10 @@
>  			#ports = <2>;
>  			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
>  			status = "disabled";
> +			/*
> +			 * No default pinmux, it will follow EHCI, use an explicit pinmux
> +			 * override if you don't enable EHCI
> +			 */
>  		};
>  
>  		apb {
> -- 
> 2.17.1
> 
