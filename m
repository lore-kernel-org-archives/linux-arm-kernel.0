From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 13 May 2014 12:17:42 -0300
Subject: [PATCH v3 7/7] ARM: sunxi: dt: add PRCM clk and reset controller
 subdevices
In-Reply-To: <1399633911-7094-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399633911-7094-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53723796.10308@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

El 09/05/14 08:11, Boris BREZILLON escribi?:
> Add DT definitions for PRCM (Power/Reset/Clock Management) clock and reset
> controller subdevices.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>   arch/arm/boot/dts/sun6i-a31.dtsi | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 9feb3f4..03d5258 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -496,6 +496,43 @@
>   		prcm at 01f01400 {
>   			compatible = "allwinner,sun6i-a31-prcm";
>   			reg = <0x01f01400 0x200>;
> +
> +			ar100: ar100_clk {
> +				compatible = "allwinner,sun6i-a31-ar100-clk";
> +				#clock-cells = <0>;
> +				clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;

You could add
				clock-output-names = "ar100";
here, so you don't depend on the node name. Your code already checks for 
it and uses it when available.

> +			};

Cheers,

Emilio
