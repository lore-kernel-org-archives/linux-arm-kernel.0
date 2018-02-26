From: stefan@agner.ch (Stefan Agner)
Date: Mon, 26 Feb 2018 09:13:34 +0100
Subject: [PATCH v2] ARM: dts: imx6ul: add wdog3 node
In-Reply-To: <20180225012446.24499-1-joerg.krause@embedded.rocks>
References: <20180225012446.24499-1-joerg.krause@embedded.rocks>
Message-ID: <9e8be8f6d33f53033b9929a9be37c889@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2018 02:24, J?rg Krause wrote:
> The i.MX6UL(L) has a WDOG3 located at start address 0x021E0000 in the
> AIPS-2 memory region [1].
> 
> [1] i.MX 6UltraLite Applications Processor Reference Manual, Rev. 1,
>     04/2016, Table-2-3 AIPS-2 memory map, p. 166

And it seems that WDOG3 is also available on 6ULL, so imx6ull.dtsi
should be fine.

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
> ---
> v2:
>  * Fix IRQ number
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 81c426e1b664..1241972b16ba 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -931,6 +931,14 @@
>  				status = "disabled";
>  			};
>  
> +			wdog3: wdog at 21e4000 {
> +				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
> +				reg = <0x021e4000 0x4000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX6UL_CLK_WDOG3>;
> +				status = "disabled";
> +			};
> +
>  			uart2: serial at 21e8000 {
>  				compatible = "fsl,imx6ul-uart",
>  					     "fsl,imx6q-uart";
