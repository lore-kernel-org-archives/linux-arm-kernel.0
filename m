From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 07 Mar 2014 16:22:26 +0000
Subject: [PATCH V3 03/12] ARM: shmobile: r7s72100: add essential clock
 nodes to dtsi
In-Reply-To: <1394208048-32495-4-git-send-email-wsa@the-dreams.de>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1394208048-32495-4-git-send-email-wsa@the-dreams.de>
Message-ID: <5319F242.70903@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/14 16:00, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>

> +		/* MSTP clocks */
> +		mstp3_clks: mstp3_clks at fcfe0420 {
> +			#clock-cells = <1>;
> +			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0xfcfe0420 4>;
> +			clocks = <&p0_clk>;
> +			renesas,clock-indices = <R7S72100_CLK_MTU2>;
> +			clock-output-names = "mtu2";
> +		};
> +
> +		mstp4_clks: mstp4_clks at fcfe0424 {
> +			#clock-cells = <1>;
> +			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0xfcfe0424 4>;
> +			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>,
> +				 <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
> +			renesas,clock-indices = <
> +				R7S72100_CLK_SCIF0 R7S72100_CLK_SCIF1 R7S72100_CLK_SCIF2 R7S72100_CLK_SCIF3
> +				R7S72100_CLK_SCIF4 R7S72100_CLK_SCIF5 R7S72100_CLK_SCIF6 R7S72100_CLK_SCIF7
> +			>;
> +			clock-output-names = "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scif6", "scif7";

FYI: I'm pushing a patch through to make clock-indices a standard
DT property that will allow the of_clk_get_name() function to
work properly. With this, the renesas,clock-indices will be
replaced with the clock-indices.
-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genies
