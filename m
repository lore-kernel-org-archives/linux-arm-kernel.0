From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 21:26:48 +0100
Subject: [PATCHv5 06/10] arm: mvebu: define and use common Armada 370
 UART pinctrl settings
In-Reply-To: <455f2c2ebd8075c43f1fe60b99de10160310f780.1416598537.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
 <455f2c2ebd8075c43f1fe60b99de10160310f780.1416598537.git.arno@natisbad.org>
Message-ID: <20141121202648.GF20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud
> 
> This patch defines common Armada 370 pinctrl settings for uart0 and
> uart1 interfaces:
> 
>  uart0: MPP0-1 as default
>  uart1: MPP41-42 as default
> 
> Note: this patch has the potential to break out-of-tree users w/o
> specific pinctrl settings for their uart interfaces if the default
> above does not match their config.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index f1284ae0cddd..b8de32b2a265 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -211,6 +211,21 @@
>  				pinctrl-names = "default";
>  			};
>  
> +			/*
> +			 * Default UART pinctrl setting without RTS/CTS, can
> +			 * be overwritten on board level if a different
> +			 * configuration is used.
> +			 */
> +			uart0: serial at 12000 {
> +				pinctrl-0 = <&uart0_pins>;
> +				pinctrl-names = "default";
> +			};
> +
> +			uart1: serial at 12100 {
> +				pinctrl-0 = <&uart1_pins>;
> +				pinctrl-names = "default";
> +			};
> +

And again.

    Andrew
