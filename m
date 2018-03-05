From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Mar 2018 09:42:48 +0100
Subject: [PATCH] ARM: dts: stm32: add SPI support on STM32H743 SoC
In-Reply-To: <1519814190-3208-1-git-send-email-amelie.delaunay@st.com>
References: <1519814190-3208-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <f14b8e89-6487-1a1c-7f66-a0dcd3cd705b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie

On 02/28/2018 11:36 AM, Amelie Delaunay wrote:
> This patch adds all SPI instances of the STM32H743 SoC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---

Applied on stm32-next.

Thanks.
Alex

>   arch/arm/boot/dts/stm32h743.dtsi | 61 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 3a28cd2..2bb103e 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -101,6 +101,27 @@
>   			};
>   		};
>   
> +		spi2: spi at 40003800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40003800 0x400>;
> +			interrupts = <36>;
> +			clocks = <&rcc SPI2_CK>;
> +			status = "disabled";
> +
> +		};
> +
> +		spi3: spi at 40003c00 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40003c00 0x400>;
> +			interrupts = <51>;
> +			clocks = <&rcc SPI3_CK>;
> +			status = "disabled";
> +		};
> +
>   		usart2: serial at 40004400 {
>   			compatible = "st,stm32f7-uart";
>   			reg = <0x40004400 0x400>;
> @@ -141,6 +162,36 @@
>   			clocks = <&rcc USART1_CK>;
>   		};
>   
> +		spi1: spi at 40013000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40013000 0x400>;
> +			interrupts = <35>;
> +			clocks = <&rcc SPI1_CK>;
> +			status = "disabled";
> +		};
> +
> +		spi4: spi at 40013400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40013400 0x400>;
> +			interrupts = <84>;
> +			clocks = <&rcc SPI4_CK>;
> +			status = "disabled";
> +		};
> +
> +		spi5: spi at 40015000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40015000 0x400>;
> +			interrupts = <85>;
> +			clocks = <&rcc SPI5_CK>;
> +			status = "disabled";
> +		};
> +
>   		dma1: dma at 40020000 {
>   			compatible = "st,stm32-dma";
>   			reg = <0x40020000 0x400>;
> @@ -262,6 +313,16 @@
>   			reg = <0x58000400 0x400>;
>   		};
>   
> +		spi6: spi at 58001400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x58001400 0x400>;
> +			interrupts = <86>;
> +			clocks = <&rcc SPI6_CK>;
> +			status = "disabled";
> +		};
> +
>   		lptimer2: timer at 58002400 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> 
