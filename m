From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 May 2018 09:50:02 +0200
Subject: [PATCH] ARM: dts: stm32: add USB Host (USBH) support to
 stm32mp157c
In-Reply-To: <1524569080-22475-1-git-send-email-amelie.delaunay@st.com>
References: <1524569080-22475-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <2c40257d-f368-d057-b397-bc8e085f3bef@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 04/24/2018 01:24 PM, Amelie Delaunay wrote:
> Add support for USBH (USB Host) to STM32MP157C SoC.
> USBH is a USB Host controller supporting the standard registers used for
> full- and low-speed (OHCI controller) and high-speed (EHCI controller).
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..cc06d6b 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -5,6 +5,7 @@
>    */
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/stm32mp1-clks.h>
> +#include <dt-bindings/reset/stm32mp1-resets.h>
>   
>   / {
>   	#address-cells = <1>;
> @@ -167,6 +168,25 @@
>   			#reset-cells = <1>;
>   		};
>   
> +		usbh_ohci: usbh-ohci at 5800c000 {
> +			compatible = "generic-ohci";
> +			reg = <0x5800c000 0x1000>;
> +			clocks = <&rcc USBH>;
> +			resets = <&rcc USBH_R>;
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		usbh_ehci: usbh-ehci at 5800d000 {
> +			compatible = "generic-ehci";
> +			reg = <0x5800d000 0x1000>;
> +			clocks = <&rcc USBH>;
> +			resets = <&rcc USBH_R>;
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			companion = <&usbh_ohci>;
> +			status = "disabled";
> +		};
> +
>   		usart1: serial at 5c000000 {
>   			compatible = "st,stm32h7-uart";
>   			reg = <0x5c000000 0x400>;
> 

Applied on stm32-next.

Thanks.
Alex
