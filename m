From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 26 Jul 2017 18:23:01 +0200
Subject: [PATCH 1/2] arm: dts: stm32: add cec for stm32f7 familly
In-Reply-To: <1500367869-566-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1500367869-566-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <99b4336f-f274-f88b-6f52-8603d4057fb2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 07/18/2017 10:51 AM, Benjamin Gaignard wrote:
> add cec in devicetree for stm32f7 familly
> 
> version 1.1:
> - with correct slew rate
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   arch/arm/boot/dts/stm32f746.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index 0c3dd1f..770e474 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -167,6 +167,15 @@
>   			status = "disabled";
>   		};
>   
> +		cec: cec at 40006c00 {
> +			compatible = "st,stm32-cec";
> +			reg = <0x40006C00 0x400>;
> +			interrupts = <94>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CEC)>, <&rcc 1 CLK_HDMI_CEC>;
> +			clock-names = "cec", "hdmi-cec";
> +			status = "disabled";
> +		};
> +
>   		usart7: serial at 40007800 {
>   			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>   			reg = <0x40007800 0x400>;
> @@ -339,6 +348,15 @@
>   				st,bank-name = "GPIOK";
>   			};
>   
> +			cec_pins_a: cec at 0 {
> +				pins {
> +					pinmux = <STM32F746_PA15_FUNC_HDMI_CEC>;
> +					slew-rate = <0>;
> +					drive-open-drain;
> +					bias-disable;
> +				};
> +			};
> +
>   			usart1_pins_a: usart1 at 0 {
>   				pins1 {
>   					pinmux = <STM32F746_PA9_FUNC_USART1_TX>;
> 

After minor changes, applied on stm32-dt-for-v4.14 branch.

Thanks
Alex
