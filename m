From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 21:10:59 -0500
Subject: [PATCH 1/7] dt-bindings: usb: Document the STM32F7xx DWC2 USB
 OTG HS core binding
In-Reply-To: <1502962386-6683-2-git-send-email-amelie.delaunay@st.com>
References: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
 <1502962386-6683-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170822021059.suqqn7332sjbvfj3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 11:33:00AM +0200, Amelie Delaunay wrote:
> This patch adds binding documentation for DWC2 controller in HS mode found
> on STMicroelectronics STM32F7xx SoC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index fcf199b..e64d903 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -19,6 +19,8 @@ Required properties:
>    configured in FS mode;
>    - "st,stm32f4x9-hsotg": The DWC2 USB HS controller instance in STM32F4x9 SoCs
>    configured in HS mode;
> +  - "st,stm32f7xx-hsotg": The DWC2 USB HS controller instance in STM32F7xx SoCs
> +    configured in HS mode;

Don't use wildcards in compatible strings (not sure how the previous one 
snuck in). Just "stm32f7" (i.e. just drop the xx) is probably specific 
enough though.

>  - reg : Should contain 1 register range (address and length)
>  - interrupts : Should contain 1 interrupt
>  - clocks: clock provider specifier
> -- 
> 2.7.4
> 
