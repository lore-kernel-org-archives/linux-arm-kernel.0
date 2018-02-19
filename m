From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Mon, 19 Feb 2018 08:34:28 +0000
Subject: [PATCH 1/3] ARM: dts: stm32: add USB OTG HS support for STM32H743
 SoC
In-Reply-To: <1518710604-21632-2-git-send-email-amelie.delaunay@st.com>
References: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
 <1518710604-21632-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <30e056af-7de7-64b4-0383-8639f5f1b962@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2018 05:03 PM, Amelie Delaunay wrote:
> This patch adds support for USB OTG HS on STM32H743 SoC.
> USB OTG HS controller is the same than the one used on STM32F7 SoCs.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 38d7cb8..65d4509 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -217,6 +217,18 @@
>   			};
>   		};
>   
> +		usbotg_hs: usb at 40040000 {
> +			compatible = "st,stm32f7xx-hsotg";
Need to change the compatible and use the updated one [1]. I send a v2.

[1] https://patchwork.kernel.org/patch/10222153/
> +			reg = <0x40040000 0x40000>;
> +			interrupts = <77>;
> +			clocks = <&rcc USB1OTG_CK>;
> +			clock-names = "otg";
> +			g-rx-fifo-size = <256>;
> +			g-np-tx-fifo-size = <32>;
> +			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
> +			status = "disabled";
> +		};
> +
>   		mdma1: dma at 52000000 {
>   			compatible = "st,stm32h7-mdma";
>   			reg = <0x52000000 0x1000>;
> 
