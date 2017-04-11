From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 04:00:13 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx7: add USDHC NAND and IPG clock to
 SDHC instances
In-Reply-To: <20170410210015.1620-2-stefan@agner.ch>
References: <20170410210015.1620-1-stefan@agner.ch>
 <20170410210015.1620-2-stefan@agner.ch>
Message-ID: <20170411200013.GB13181@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 02:00:15PM -0700, Stefan Agner wrote:
> The USDHC instances need the USDHC NAND and IPG clock in order to
> operate. Reference them properly by replacing the dummy clocks with
> the actual clocks.
> 
> Note that both clocks are currently implicitly enabled since they
> are part of the i.MX 7 clock drivers init_on list. This might
> change in the future.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
> This patch depends on "clk: imx7d: add the missing ipg_root_clk"
> which adds the IPG clock.
> 
> --
> Stefan
> 
>  arch/arm/boot/dts/imx7s.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index c4f12fd2e044..843eb379e1ea 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -934,8 +934,8 @@
>  				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
>  				reg = <0x30b40000 0x10000>;
>  				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> -					<&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_IPG_ROOT_CLK>,
> +					<&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>,
>  					<&clks IMX7D_USDHC1_ROOT_CLK>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> @@ -946,8 +946,8 @@
>  				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
>  				reg = <0x30b50000 0x10000>;
>  				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> -					<&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_IPG_ROOT_CLK>,
> +					<&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>,
>  					<&clks IMX7D_USDHC2_ROOT_CLK>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> @@ -958,8 +958,8 @@
>  				compatible = "fsl,imx7d-usdhc", "fsl,imx6sl-usdhc";
>  				reg = <0x30b60000 0x10000>;
>  				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> -					<&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_IPG_ROOT_CLK>,
> +					<&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>,
>  					<&clks IMX7D_USDHC3_ROOT_CLK>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> -- 
> 2.12.1
> 
