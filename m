From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 05 Jan 2018 11:27:25 +0100
Subject: [PATCH 6/6] ARM64: dts: meson-axg: enable the UART_A controller
In-Reply-To: <20180105095621.196472-7-yixun.lan@amlogic.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
 <20180105095621.196472-7-yixun.lan@amlogic.com>
Message-ID: <1515148045.5048.19.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-01-05 at 17:56 +0800, Yixun Lan wrote:
> The UART_A is connect to a BT module in the S400 board.

The UART_A is connected to a BT module on the S400 board.
                     --                --

Apart from this:
Acked-by: Jerome Brunet <jbrunet@baylibre.com>


> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 2b79be356996..7e03b8da4856 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -14,9 +14,16 @@
>  
>  	aliases {
>  		serial0 = &uart_AO;
> +		serial1 = &uart_A;
>  	};
>  };
>  
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
>  &uart_AO {
>  	status = "okay";
>  	pinctrl-0 = <&uart_ao_a_pins>;
