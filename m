From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 27 Jul 2017 09:29:55 +0200
Subject: [PATCH 4/4] ARM: dts: stm32: Add DAC support on stm32f429
In-Reply-To: <1499693040-12994-5-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
 <1499693040-12994-5-git-send-email-fabrice.gasnier@st.com>
Message-ID: <5b66624c-3a4c-a3af-72b2-d867cf880722@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/10/2017 03:24 PM, Fabrice Gasnier wrote:
> Add support for DAC (Digital to Analog Converter) to STM32F429.
> STM32F429 DAC has two output channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index b2a2b5c..f15f633 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -354,6 +354,31 @@
>   			status = "disabled";
>   		};
>   
> +		dac: dac at 40007400 {
> +			compatible = "st,stm32f4-dac-core";
> +			reg = <0x40007400 0x400>;
> +			resets = <&rcc STM32F4_APB1_RESET(DAC)>;
> +			clocks = <&rcc 0 STM32F4_APB1_CLOCK(DAC)>;
> +			clock-names = "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			dac1: dac at 1 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <1>;
> +				status = "disabled";
> +			};
> +
> +			dac2: dac at 2 {
> +				compatible = "st,stm32-dac";
> +				#io-channels-cells = <1>;
> +				reg = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		usart7: serial at 40007800 {
>   			compatible = "st,stm32-usart", "st,stm32-uart";
>   			reg = <0x40007800 0x400>;
> 
Applied on stm32-dt-for-v4.14 branch.

Thanks
Alex
