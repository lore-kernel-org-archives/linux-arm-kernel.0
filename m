From: stefan@agner.ch (Stefan Agner)
Date: Mon, 15 May 2017 13:01:50 -0700
Subject: [PATCH] ARM: dts: imx7s: Avoid using dummy clocks for usdhc
In-Reply-To: <1494875593-22796-1-git-send-email-festevam@gmail.com>
References: <1494875593-22796-1-git-send-email-festevam@gmail.com>
Message-ID: <9dfe6d0f307b105c4debf0c2a3eee743@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-15 12:13, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Use the proper usdhc clocks instead of passing dummy ones.

That patch?

https://patchwork.kernel.org/patch/9674277/

Already applied I think...

--
Stefan

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index c4f12fd..843eb37 100644
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
