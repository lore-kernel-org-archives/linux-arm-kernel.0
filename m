From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 15:39:34 +0100
Subject: [PATCHv3 RESEND 4/8] ARM: dts: stm32: Add RTC support for
 STM32F429 MCU
In-Reply-To: <1484573388-590-2-git-send-email-amelie.delaunay@st.com>
References: <1484573388-590-1-git-send-email-amelie.delaunay@st.com>
 <1484573388-590-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <637d0251-0d22-766f-15ea-c87819468a90@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/16/2017 02:29 PM, Amelie Delaunay wrote:
> This patch adds STM32 RTC bindings for STM32F429.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 557c1f4..f05a9d9 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -125,6 +125,20 @@
>  			status = "disabled";
>  		};
>
> +		rtc: rtc at 40002800 {
> +			compatible = "st,stm32-rtc";
> +			reg = <0x40002800 0x400>;
> +			clocks = <&rcc 1 CLK_RTC>;
> +			clock-names = "ck_rtc";
> +			assigned-clocks = <&rcc 1 CLK_RTC>;
> +			assigned-clock-parents = <&rcc 1 CLK_LSE>;
> +			interrupt-parent = <&exti>;
> +			interrupts = <17 1>;
> +			interrupt-names = "alarm";
> +			st,syscfg = <&pwrcfg>;
> +			status = "disabled";
> +		};
> +
>  		usart2: serial at 40004400 {
>  			compatible = "st,stm32-usart", "st,stm32-uart";
>  			reg = <0x40004400 0x400>;
>
Applied on stm32-dt-for-v4.11

Thanks
Alex
