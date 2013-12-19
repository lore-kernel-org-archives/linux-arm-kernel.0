From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 13:42:15 +0800
Subject: [PATCH 1/4] ARM: dts: imx6sl: Adding cpu frequency table
In-Reply-To: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
References: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20131219054213.GT6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:50:53PM -0800, John Tobias wrote:
> Device tree for iMX6SL doesn't have an existing cpu frequency table.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 28558f1..473d54b 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -38,6 +38,21 @@
>  			device_type = "cpu";
>  			reg = <0x0>;
>  			next-level-cache = <&L2>;
> +			operating-points = <
> +				/* kHz    uV */
> +				996000  1275000
> +				792000  1175000
> +				396000  975000
> +			>;

Anson is pushing VDDSOC/PU voltage settings upstream.  We may want to
add the following VDDSOC/PU operating-points as well.

	fsl,soc-operating-points = <
		/* ARM kHz	SOC-PU uV */
		996000		1225000
		792000		1175000
		396000		1175000
	>;

Shawn

> +			clock-latency = <61036>; /* two CLK32 periods */
> +			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>,
> +					<&clks IMX6SL_CLK_STEP>, <&clks IMX6SL_CLK_PLL1_SW>,
> +					<&clks IMX6SL_CLK_PLL1_SYS>;
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
