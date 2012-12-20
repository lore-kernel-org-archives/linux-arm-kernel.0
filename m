From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Dec 2012 11:42:41 +0100
Subject: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for adc
In-Reply-To: <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <50D2EBA1.4050305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 19/12/2012 19:37, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> at91 adc offers the choice between two resolutions: low and high.
> The low and high resolution values depends on adc IP version, as many IP
> properties have been exposed through device tree, these settings have also
> been added to the dt bindings.
> 
> Update at the same time the dtsi.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> [plagnioj at jcrosoft.com: udpate current adc dt support]
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-iio at vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../devicetree/bindings/arm/atmel-adc.txt          |   11 +++
>  arch/arm/boot/dts/at91sam9260.dtsi                 |    3 +
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    3 +
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |    3 +
>  drivers/iio/adc/at91_adc.c                         |   74 ++++++++++++++++++--
>  5 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> index c63097d..fd2d69e 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> @@ -14,9 +14,17 @@ Required properties:
>    - atmel,adc-status-register: Offset of the Interrupt Status Register
>    - atmel,adc-trigger-register: Offset of the Trigger Register
>    - atmel,adc-vref: Reference voltage in millivolts for the conversions
> +  - atmel,adc-res: List of resolution in bits supported by the ADC. List size
> +		   must be two at least.
> +  - atmel,adc-res-names: Contains one identifier string for each resolution
> +			 in atmel,adc-res property. "lowres" and "highres"
> +			 identifiers are required.
>  
>  Optional properties:
>    - atmel,adc-use-external: Boolean to enable of external triggers
> +  - atmel,adc-use-res: String corresponding to an identifier from
> +		       atmel,adc-res-names property. If not specified, the highest
> +		       resolution will be used.


I'm wondering, why are you using such a complex dt parsing code, and
bindings, when you only requires a boolean to switch between 8 and 10
bits mode (which seem to be the only thing you support)?

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
