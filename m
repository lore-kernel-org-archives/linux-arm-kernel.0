From: robh@kernel.org (Rob Herring)
Date: Tue, 22 Dec 2015 18:51:18 -0600
Subject: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
In-Reply-To: <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
 <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151223005118.GA29457@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 10:24:08AM +0100, Ludovic Desroches wrote:
> This driver supports the new version of the Atmel ADC device introduced
> with the SAMA5D2 SoC family.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  27 ++
>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/at91_adc8xx.c                      | 417 +++++++++++++++++++++
>  4 files changed, 456 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
>  create mode 100644 drivers/iio/adc/at91_adc8xx.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> new file mode 100644
> index 0000000..64ad6a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> @@ -0,0 +1,27 @@
> +* AT91 SAMA5D2 Analog to Digital Converter (ADC)
> +
> +Required properties:
> +  - compatible: Should be "atmel,sama5d2-adc".
> +  - reg: Should contain ADC registers location and length.
> +  - interrupts: Should contain the IRQ line for the ADC.
> +  - clocks: phandles to clocks.
> +  - clock-names: tuple listing clock names.
> +      Required elements: "adc_clk", "adc_op_clk". "adc_clk" is the peripheral
> +      clock, "adc_clk" is the sampling clock.
> +  - vref-supply: Supply used as reference for conversions.
> +
> +Optional properties:
> +  - vddana-supply: Supply for the adc device.

What makes a supply optional? If chip dependent, then then you need a 
more specific compatible string.

Rob
