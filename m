From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 14 Aug 2013 18:45:28 +0900
Subject: [PATCH 2/2] ARM: dts: Add DMA controller node info on Exynos5420.
In-Reply-To: <1373458449-19039-3-git-send-email-padma.v@samsung.com>
References: <1373458449-19039-1-git-send-email-padma.v@samsung.com>
 <1373458449-19039-3-git-send-email-padma.v@samsung.com>
Message-ID: <110501ce98d3$0288bc40$079a34c0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> Exynos5420 has one separate DMA controller for I2S0 and PCM0. This patch
> adds the same node on exynos5420 dtsi and adds the DMA clk info for the
> remaining DMA controllers.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   33
+++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi
> index a84f5f1..7035a4b 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -137,6 +137,39 @@
>  		interrupts = <0 47 0>;
>  	};
> 
> +	amba {
> +		pdma0: pdma at 121A0000 {
> +			clocks = <&clock 362>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		pdma1: pdma at 121B0000 {
> +			clocks = <&clock 363>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		mdma0: mdma at 10800000 {
> +			clocks = <&clock 473>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		mdma1: mdma at 11C10000 {
> +			clocks = <&clock 442>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		adma: adma at 03880000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x03880000 0x1000>;
> +			interrupts = <0 110 0>;
> +			clocks = <&clock_audss EXYNOS_ADMA>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <6>;
> +			#dma-requests = <16>;
> +		};
> +	};
> +
>  	serial at 12C00000 {
>  		clocks = <&clock 257>, <&clock 128>;
>  		clock-names = "uart", "clk_uart_baud0";
> --
> 1.7.4.4

See my comments on 1st patch and you need to re-spin for dmac on exynos5420.

Thanks,
Kukjin
