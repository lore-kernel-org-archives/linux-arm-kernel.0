From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 27 Aug 2018 16:36:55 +0200
Subject: [PATCH v7 RESEND 1/2] ARM: dts: at91: sama5d2: add channel cells
 for ADC device
In-Reply-To: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
References: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180827143655.GB23428@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2018 16:57:12+0300, Eugen Hristev wrote:
> Preparing the ADC device to connect channel consumer drivers
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Resending after merge window that includes the bindings was closed.
> Rebased on 4.19-rc1 : no changes
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

I was going to dig those up, applied now, thanks!

> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 61f68e5..f06ba99 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -47,6 +47,7 @@
>  #include <dt-bindings/dma/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
>  
>  / {
>  	model = "Atmel SAMA5D2 family SoC";
> @@ -1437,6 +1438,7 @@
>  				atmel,max-sample-rate-hz = <20000000>;
>  				atmel,startup-time-ms = <4>;
>  				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
> +				#io-channel-cells = <1>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
