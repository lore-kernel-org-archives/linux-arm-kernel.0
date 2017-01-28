From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 28 Jan 2017 18:39:58 +0000
Subject: [PATCH v2 4/7] Documentation: dt: iio: stm32-adc: optional dma
 support
In-Reply-To: <1485440915-30119-5-git-send-email-fabrice.gasnier@st.com>
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
 <1485440915-30119-5-git-send-email-fabrice.gasnier@st.com>
Message-ID: <467e84b4-58f7-a650-b233-46c5fc8232ee@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/17 14:28, Fabrice Gasnier wrote:
> STM32 ADC can use dma. Add dt documentation for optional dma support.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Rob Herring <robh@kernel.org>
Applied.
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 49ed82e..5dfc88e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -53,6 +53,11 @@ Required properties:
>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>  
> +Optional properties:
> +- dmas: Phandle to dma channel for this ADC instance.
> +  See ../../dma/dma.txt for details.
> +- dma-names: Must be "rx" when dmas property is being used.
> +
>  Example:
>  	adc: adc at 40012000 {
>  		compatible = "st,stm32f4-adc-core";
> @@ -77,6 +82,8 @@ Example:
>  			interrupt-parent = <&adc>;
>  			interrupts = <0>;
>  			st,adc-channels = <8>;
> +			dmas = <&dma2 0 0 0x400 0x0>;
> +			dma-names = "rx";
>  		};
>  		...
>  		other adc child nodes follow...
> 
