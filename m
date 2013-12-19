From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 11:13:05 +0800
Subject: [PATCH] ARM: imx: enable cpufreq for i.mx6dl
In-Reply-To: <1387465330-15667-1-git-send-email-b20788@freescale.com>
References: <1387465330-15667-1-git-send-email-b20788@freescale.com>
Message-ID: <20131219031304.GR6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 10:02:10AM -0500, Anson Huang wrote:
> This patch adds cpufreq dts for i.mx6dl to support cpufreq driver.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, with patch subject changed to 'ARM: dts: imx6dl: enable cpufreq
support'.

Shawn

> ---
>  arch/arm/boot/dts/imx6dl.dtsi |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index b2f2699..e2ec0fb 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -23,6 +23,26 @@
>  			device_type = "cpu";
>  			reg = <0>;
>  			next-level-cache = <&L2>;
> +			operating-points = <
> +				/* kHz    uV */
> +				996000  1275000
> +				792000  1175000
> +				396000  1075000
> +			>;
> +			fsl,soc-operating-points = <
> +				/* ARM kHz  SOC-PU uV */
> +				996000	1175000
> +				792000	1175000
> +				396000	1175000
> +			>;
> +			clock-latency = <61036>; /* two CLK32 periods */
> +			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
> +				 <&clks 17>, <&clks 170>;
> +			clock-names = "arm", "pll2_pfd2_396m", "step",
> +				      "pll1_sw", "pll1_sys";
> +			arm-supply = <&reg_arm>;
> +			pu-supply = <&reg_pu>;
> +			soc-supply = <&reg_soc>;
>  		};
>  
>  		cpu at 1 {
> -- 
> 1.7.9.5
> 
> 
