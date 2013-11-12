From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 12 Nov 2013 20:13:11 +0900
Subject: [RESEND] [PATCH V3] ARM: dts: Add DMA controller node info on
 Exynos5420.
In-Reply-To: <1381137944-30503-1-git-send-email-l.krishna@samsung.com>
References: <1381137944-30503-1-git-send-email-l.krishna@samsung.com>
Message-ID: <086601cedf98$2cb9f310$862dd930$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leela Krishna Amudala wrote:
> 
+ dt ml.

> From: Padmavathi Venna <padma.v@samsung.com>
> 
> This patch adds dma controller node info on Exynos5420.
> Exynos5420 has adma for audio IPs. As adma clk is dependent
> on audss clk provider that will be added later.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
> Change since V2:
> 	- Removed adma node as adma clock is dependent audss clock provider.
> 
> Changes since V1:
>         - In V1, dma node common stuff was added in common exynos5.dtsi
file.
>           This was removed as per Kukjin comment and added in
> exynos5420.dtsi.
> 
>  arch/arm/boot/dts/exynos5420.dtsi |   52
> +++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi
> index d537cd7..15465f8 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -186,6 +186,58 @@
>  		status = "okay";
>  	};
> 
> +	amba {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "arm,amba-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		pdma0: pdma at 121A0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121A0000 0x1000>;
> +			interrupts = <0 34 0>;
> +			clocks = <&clock 362>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		pdma1: pdma at 121B0000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x121B0000 0x1000>;
> +			interrupts = <0 35 0>;
> +			clocks = <&clock 363>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +		};
> +
> +		mdma0: mdma at 10800000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x10800000 0x1000>;
> +			interrupts = <0 33 0>;
> +			clocks = <&clock 473>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +
> +		mdma1: mdma at 11C10000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x11C10000 0x1000>;
> +			interrupts = <0 124 0>;
> +			clocks = <&clock 442>;
> +			clock-names = "apb_pclk";
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
> +		};
> +	};
> +
>  	serial at 12C00000 {
>  		clocks = <&clock 257>, <&clock 128>;
>  		clock-names = "uart", "clk_uart_baud0";
> --
> 1.7.10.4

Sorry for late response.

Looks OK to me, many properties for dma are same with 5250 though...

Applied, thanks.
- Kukjin
