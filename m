From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Wed, 09 Apr 2014 11:06:55 -0300
Subject: [PATCH 07/15] ARM: sunxi: dt: define A31's APB0 clk gates node
In-Reply-To: <1397051478-4113-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <534553FF.4060401@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

El 09/04/14 10:51, Boris BREZILLON escribi?:
> Define the APB0 clk gates controlled by the PRCM (Power/Reset/Clock
> Management) block.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>   arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 3858424..61e8b34 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -141,6 +141,16 @@
>   					"ahb1_drc0", "ahb1_drc1";
>   		};
>
> +		apb0_gates: apb0_gates at 01f01428 {

Looks like this node is out of place, judging by the address. Try to 
keep them in order.

> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun6i-a31-apb0-gates-clk";
> +			reg = <0x01f01428 0x4>;
> +			clock-output-names = "apb0_pio", "apb0_ir",
> +					"apb0_timer01", "apb0_p2wi",
> +					"apb0_uart", "apb0_1wire",
> +					"apb0_i2c";
> +		};
> +
>   		apb1: apb1 at 01c20054 {
>   			#clock-cells = <0>;
>   			compatible = "allwinner,sun4i-apb0-clk";
>

Cheers,

Emilio
