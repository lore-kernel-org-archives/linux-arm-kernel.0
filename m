From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 23 Dec 2013 13:21:06 -0300
Subject: [PATCH 2/4] ARM: dts: sun7i: external clock outputs
In-Reply-To: <1387787827-11341-3-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
 <1387787827-11341-3-git-send-email-wens@csie.org>
Message-ID: <52B862F2.1020406@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 23/12/13 05:37, Chen-Yu Tsai escribi?:
> This commit adds the two external clock outputs available on A20 to
> its device tree. A dummy fixed factor clock is also added to serve as
> the first input of the clock outputs, which according to AW's A20 user
> manual, is the 24MHz oscillator divided by 750.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
(,,,)
> +		clk_out_a: clk_out_a at 01c201f0 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun7i-a20-out-clk";
> +			reg = <0x01c201f0 0x4>;
> +			clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
> +		};

These nodes should, as per Maxime's recommendation, look more like

	clk_out_a: clk at 01c201f0 {
		#clock-cells = <0>;
		compatible = "allwinner,sun7i-a20-out-clk";
		reg = <0x01c201f0 0x4>;
		clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
		clk-output-names = "clk_out_a";
	};

Cheers,

Emilio
