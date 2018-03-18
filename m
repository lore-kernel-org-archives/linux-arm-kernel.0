From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 19 Mar 2018 00:49:34 +0100
Subject: [PATCH v1 08/19] arm: dts: mt7623: enable three available UARTs
 on bananapi-r2
In-Reply-To: <f2e72b8c9f5755ee8943dd7be7f9b9ec50f52c9b.1519378872.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <f2e72b8c9f5755ee8943dd7be7f9b9ec50f52c9b.1519378872.git.sean.wang@mediatek.com>
Message-ID: <32322310-2279-03bb-3023-f3803f57b050@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/23/2018 11:16 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> On bpi-r2 board, totally there're four UARTs which we usually called
> uart[0-3] helpful to extend slow-I/O devices. Among those ones, uart2 has
> dedicated pin slot which is used to console log. uart[0-1] appear at the
> 40-pins connector and uart3 has no pinout, but just has test points (TP47
> for TX and TP48 for RX, respectively) nearby uart2, but we don't enable
> uart3 in the patch. The missing pinctrl is also being supplemented for
> those newly added devices.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Pushed to v4.16-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 8ef91d6..6b760be 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -470,6 +470,13 @@
>  				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
>  		};
>  	};
> +
> +	uart2_pins_a: uart at 2 {
> +		pins_dat {
> +			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
> +				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
> +		};
> +	};
>  };
>  
>  &pwm {
> @@ -515,16 +522,18 @@
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> -	status = "disabled";
> +	status = "okay";
>  };
>  
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins_a>;
> -	status = "disabled";
> +	status = "okay";
>  };
>  
>  &uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins_a>;
>  	status = "okay";
>  };
>  
> 
