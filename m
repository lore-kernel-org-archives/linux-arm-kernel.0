From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 13 Nov 2018 10:58:06 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: Add hwlock for pinctrl
In-Reply-To: <20181113095142.32015-4-benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
 <20181113095142.32015-4-benjamin.gaignard@st.com>
Message-ID: <2e76818f-28a0-1151-11f0-a9e8d3b5fd09@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin

On 11/13/18 10:51 AM, Benjamin Gaignard wrote:
> Define a hwspinlock to be used by pin-controller
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 

In commit title please add for which SoC it is targeted. If you don't 
have to send new version for driver or dt-bindings, I will do it when 
I'll apply.

regards
Alex

> diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> index c4851271e810..2886e5a6ac27 100644
> --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> @@ -14,6 +14,7 @@
>   			ranges = <0 0x50002000 0xa400>;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&exti 0x60 0xff>;
> +			hwlocks = <&hsem 0>;
>   			pins-are-numbered;
>   
>   			gpioa: gpio at 50002000 {
> 
