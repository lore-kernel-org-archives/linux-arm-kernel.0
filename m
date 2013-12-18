From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Dec 2013 15:37:57 +0800
Subject: [PATCH 1/4] iMX6SL frequency table
In-Reply-To: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20131218073755.GG6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:17:28PM -0800, John Tobias wrote:
>     Device tree for iMX6SL doesn't have an existing cpu frequency table.

Drop these leading spaces.

> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

For such imx6sl dts changes, please put a prefix 'ARM: dts: imx6sl: ...'
on the patch subject.

> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 28558f1..0a2c73c 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -38,6 +38,20 @@
>  			device_type = "cpu";
>  			reg = <0x0>;
>  			next-level-cache = <&L2>;
> +			operating-points = <
> +				/* kHz    uV */
> +				996000  1250000 /* for consumer grade only */
> +				792000  1150000
> +				396000  1050000

Please see my reply to your previous patch.

> +			>;
> +			clock-latency = <61036>; /* two CLK32 periods */
> +			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
> +				 <&clks IMX6SL_CLK_PLL1_SW>, <&clks IMX6SL_CLK_PLL1_SYS>;

The lines are somehow too long.  The following one might be easier to
read.

			clocks = <&clks IMX6SL_CLK_ARM>,
				 <&clks IMX6SL_CLK_PLL2_PFD2>,
				 <&clks IMX6SL_CLK_STEP>,
				 <&clks IMX6SL_CLK_PLL1_SW>,
				 <&clks IMX6SL_CLK_PLL1_SYS>;

Shawn

> +			clock-names = "arm", "pll2_pfd2_396m", "step",
> +				      "pll1_sw", "pll1_sys";
> +			arm-supply = <&reg_arm>;
> +			pu-supply = <&reg_pu>;
> +			soc-supply = <&reg_soc>;
>  		};
>  	};
>  
> -- 
> 1.8.3.2
> 
