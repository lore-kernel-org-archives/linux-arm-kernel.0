From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 19:19:46 +0100
Subject: [PATCHv3 0/8] at91_adc: documentation and device tree cleanups
In-Reply-To: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5320A542.5020101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2014 20:17, Alexandre Belloni :
> The first patch synchronise the documentation with the actual code and correct
> the example.
> 
> The second patch move the documentation to the correct location (under iio/adc)
> 
> The remaining patches correct the device trees that are using the adc, mainly
> removing unused properties and making the binding compliant with the ePAPR.

On the whole series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and stacked on at91-3.15-dt.

I think that the little modifications to the documentation can also go
the arm-soc way: there is no fundamental change to the binding, only
more coherence added.

Bye,

> Changes in v3:
>  - also remove the useless atmel,adc-clock-rate
> 
> Changes in v2:
>  - add #address-cells, #size-cells and a reg for each trigger to comply to the
>    ePAPR instead of removing the unit-address.
>  - also correct the atmel,adc-use-external-triggers property name in the
>    documentation and in the device tree that got it wrong.
> 
> Alexandre Belloni (8):
>   Documentation: dt: iio: improve atmel-adc documentation
>   Documentation: dt: iio: move arm/atmel-adc.txt to iio/adc/at91_adc.txt
>   ARM: at91/dt: at91-ariag25: remove useless adc properties
>   ARM: at91/dt: at91sam9260: remove useless adc properties
>   ARM: at91/dt: at91sam9g45: remove useless adc properties
>   ARM: at91/dt: at91sam9x5: remove useless adc properties
>   ARM: at91/dt: sama5d3: remove useless adc properties
>   ARM: at91/dt: at91-cosino: remove useless adc properties
> 
>  .../devicetree/bindings/arm/atmel-adc.txt          | 81 ---------------------
>  .../devicetree/bindings/iio/adc/at91_adc.txt       | 82 ++++++++++++++++++++++
>  arch/arm/boot/dts/at91-ariag25.dts                 |  1 -
>  arch/arm/boot/dts/at91-cosino.dtsi                 |  1 -
>  arch/arm/boot/dts/at91-cosino_mega2560.dts         |  1 -
>  arch/arm/boot/dts/at91sam9260.dtsi                 | 11 +--
>  arch/arm/boot/dts/at91sam9g45.dtsi                 | 11 +--
>  arch/arm/boot/dts/at91sam9x5.dtsi                  | 13 ++--
>  arch/arm/boot/dts/sama5d3.dtsi                     | 13 ++--
>  arch/arm/boot/dts/sama5d3xdm.dtsi                  |  1 -
>  10 files changed, 108 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/atmel-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
> 


-- 
Nicolas Ferre
