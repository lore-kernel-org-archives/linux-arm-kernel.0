From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 21 Apr 2018 16:36:51 +0100
Subject: [PATCH 1/3] dt-bindings: iio: stm32-adc: add support for STM32MP1.
In-Reply-To: <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
References: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
 <1524065874-434-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180421163651.2a9f19e1@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2018 17:37:52 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> Introduce "st,stm32mp1-adc" compatible to handle variants of this
> hardware such as vregready flag, interrupts, clock rate.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Pretty uncontroversial I think so I'll take this one with out
waiting Rob or Mark's time (though of course they are welcome
to offer feedback!)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index e8bb824..9994384 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -24,8 +24,11 @@ Required properties:
>  - compatible: Should be one of:
>    "st,stm32f4-adc-core"
>    "st,stm32h7-adc-core"
> +  "st,stm32mp1-adc-core"
>  - reg: Offset and length of the ADC block register set.
> -- interrupts: Must contain the interrupt for ADC block.
> +- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
> +  and stm32h7 share a common ADC interrupt line. stm32mp1 has separate
> +  lines for each ADC within ADC block.
>  - clocks: Core can use up to two clocks, depending on part used:
>    - "adc" clock: for the analog circuitry, common to all ADCs.
>      It's required on stm32f4.
> @@ -53,6 +56,7 @@ Required properties:
>  - compatible: Should be one of:
>    "st,stm32f4-adc"
>    "st,stm32h7-adc"
> +  "st,stm32mp1-adc"
>  - reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
>  - clocks: Input clock private to this ADC instance. It's required only on
>    stm32f4, that has per instance clock input for registers access.
