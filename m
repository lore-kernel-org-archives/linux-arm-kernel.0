From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 27 Dec 2017 10:45:25 +0800
Subject: [PATCH] arm64: dts: ls1088a: add DT node of watchdog
In-Reply-To: <20171227020200.25542-1-ying.zhang@freescale.com>
References: <20171227020200.25542-1-ying.zhang@freescale.com>
Message-ID: <20171227024524.GA23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 10:02:00AM +0800, ying.zhang at freescale.com wrote:
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> There are eight cores in ls1088a and each core has an watchdog,
> ls1088a can use sp805-wdt driver, so we just add DT node for it.
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   56 ++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index f5f29a2..49366d1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -369,6 +369,62 @@
>  			status = "disabled";
>  		};
>  
> +		cluster1_core0_watchdog: wdt at c000000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc000000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster1_core1_watchdog: wdt at c010000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc010000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster1_core2_watchdog: wdt at c020000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc020000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster1_core3_watchdog: wdt at c030000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc030000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster2_core0_watchdog: wdt at c100000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc100000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster2_core1_watchdog: wdt at c110000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc110000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster2_core2_watchdog: wdt at c120000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc120000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +
> +		cluster2_core3_watchdog: wdt at c130000 {
> +			compatible = "arm,sp805-wdt", "arm,primecell";
> +			reg = <0x0 0xc130000 0x0 0x1000>;
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "apb_pclk", "wdog_clk";
> +		};
> +

Please maintain the devices under simple-bus 'soc' node in order of
unit-address, when you add new device nodes.  For example, wdt at c130000
shouldn't go before gpio at 2300000.

Shawn

>  		gpio0: gpio at 2300000 {
>  			compatible = "fsl,qoriq-gpio";
>  			reg = <0x0 0x2300000 0x0 0x10000>;
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
