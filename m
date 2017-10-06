From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 6 Oct 2017 15:04:07 +0200
Subject: [PATCH v2] ARM: dts: stm32: add Timers driver for stm32f746 MCU
In-Reply-To: <1507274050-14510-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1507274050-14510-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <f0da3c4f-c4a6-93fa-11ee-a8ef1c9b054e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 10/06/2017 09:14 AM, Benjamin Gaignard wrote:
> Add Timers and it sub-nodes into DT for stm32f746 family.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - without ltdc node
>    

Applied on stm32-dt-for-v4.15 branch.

Thanks
Alex


>   arch/arm/boot/dts/stm32f746.dtsi | 260 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 260 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index 4506eb9..d0deee2 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -82,6 +82,27 @@
>   			status = "disabled";
>   		};
>   
> +		timers2: timers at 40000000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40000000 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM2)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 1 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <1>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		timer3: timer at 40000400 {
>   			compatible = "st,stm32-timer";
>   			reg = <0x40000400 0x400>;
> @@ -90,6 +111,27 @@
>   			status = "disabled";
>   		};
>   
> +		timers3: timers at 40000400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40000400 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM3)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 2 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <2>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		timer4: timer at 40000800 {
>   			compatible = "st,stm32-timer";
>   			reg = <0x40000800 0x400>;
> @@ -98,6 +140,27 @@
>   			status = "disabled";
>   		};
>   
> +		timers4: timers at 40000800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40000800 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM4)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 3 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <3>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		timer5: timer at 40000c00 {
>   			compatible = "st,stm32-timer";
>   			reg = <0x40000c00 0x400>;
> @@ -105,6 +168,27 @@
>   			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM5)>;
>   		};
>   
> +		timers5: timers at 40000c00 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40000C00 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM5)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 4 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <4>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		timer6: timer at 40001000 {
>   			compatible = "st,stm32-timer";
>   			reg = <0x40001000 0x400>;
> @@ -113,6 +197,22 @@
>   			status = "disabled";
>   		};
>   
> +		timers6: timers at 40001000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40001000 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM6)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			timer at 5 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <5>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		timer7: timer at 40001400 {
>   			compatible = "st,stm32-timer";
>   			reg = <0x40001400 0x400>;
> @@ -121,6 +221,73 @@
>   			status = "disabled";
>   		};
>   
> +		timers7: timers at 40001400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40001400 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM7)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			timer at 6 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <6>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		timers12: timers at 40001800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40001800 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM12)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 11 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <11>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		timers13: timers at 40001c00 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40001C00 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM13)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +		};
> +
> +		timers14: timers at 40002000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40002000 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM14)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +		};
> +
>   		rtc: rtc at 40002800 {
>   			compatible = "st,stm32-rtc";
>   			reg = <0x40002800 0x400>;
> @@ -183,6 +350,48 @@
>   			status = "disabled";
>   		};
>   
> +		timers1: timers at 40010000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40010000 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM1)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 0 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		timers8: timers at 40010400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40010400 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM8)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 7 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <7>;
> +				status = "disabled";
> +			};
> +		};
> +
>   		usart1: serial at 40011000 {
>   			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>   			reg = <0x40011000 0x400>;
> @@ -212,6 +421,57 @@
>   			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>   		};
>   
> +		timers9: timers at 40014000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40014000 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM9)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +
> +			timer at 8 {
> +				compatible = "st,stm32-timer-trigger";
> +				reg = <8>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		timers10: timers at 40014400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40014400 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM10)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +		};
> +
> +		timers11: timers at 40014800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32-timers";
> +			reg = <0x40014800 0x400>;
> +			clocks = <&rcc 0 STM32F7_APB2_CLOCK(TIM11)>;
> +			clock-names = "int";
> +			status = "disabled";
> +
> +			pwm {
> +				compatible = "st,stm32-pwm";
> +				status = "disabled";
> +			};
> +		};
> +
>   		pwrcfg: power-config at 40007000 {
>   			compatible = "syscon";
>   			reg = <0x40007000 0x400>;
> 
