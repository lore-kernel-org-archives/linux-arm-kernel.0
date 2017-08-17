From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:10:59 -0500
Subject: [PATCH 1/3] Documentation: dt: iio: at91-sama5d2_adc: add
 optional dma property
In-Reply-To: <1502368499-6739-2-git-send-email-eugen.hristev@microchip.com>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
 <1502368499-6739-2-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20170817151059.ptnzqsrzray26zlr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 03:34:57PM +0300, Eugen Hristev wrote:
> Added property for DMA configuration of the device.

"dt-bindings: iio: ..." is preferred for subject.

> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 552e7a8..5f94d47 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -17,6 +17,11 @@ Required properties:
>    This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
>    IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
>  
> +Optional properties:
> +  - dmas: Phandle to dma channel for the ADC.
> +  See ../../dma/dma.txt for details.
> +  - dma-names: Must be "rx" when dmas property is being used.

*-names is pointless when there's only one.

> +
>  Example:
>  
>  adc: adc at fc030000 {
> @@ -31,4 +36,6 @@ adc: adc at fc030000 {
>  	vddana-supply = <&vdd_3v3_lp_reg>;
>  	vref-supply = <&vdd_3v3_lp_reg>;
>  	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> +	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
> +	dma-names = "rx";
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
