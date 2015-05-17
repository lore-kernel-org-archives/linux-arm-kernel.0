From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 17 May 2015 12:39:04 +0100
Subject: [PATCH v4 2/3] Documentation: bindings: document the Berlin ADC
 driver
In-Reply-To: <1431339531-11938-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431339531-11938-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <55587DD8.20300@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/15 11:18, Antoine Tenart wrote:
> Following the addition of a Berlin ADC driver, this patch adds the
> corresponding bindings documentation.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
This has been around in this form for a good while, so I'll take the
view everyone agrees it is a good binding and apply it.

Applied to the togreg branch of iio.git - initially pushed out as testing
so the autobuilders can play with the rest of the series.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/berlin2_adc.txt       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
> new file mode 100644
> index 000000000000..908334c6b07f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
> @@ -0,0 +1,19 @@
> +* Berlin Analog to Digital Converter (ADC)
> +
> +The Berlin ADC has 8 channels, with one connected to a temperature sensor.
> +It is part of the system controller register set. The ADC node should be a
> +sub-node of the system controller node.
> +
> +Required properties:
> +- compatible: must be "marvell,berlin2-adc"
> +- interrupts: the interrupts for the ADC and the temperature sensor
> +- interrupt-names: should be "adc" and "tsen"
> +
> +Example:
> +
> +adc: adc {
> +	compatible = "marvell,berlin2-adc";
> +	interrupt-parent = <&sic>;
> +	interrupts = <12>, <14>;
> +	interrupt-names = "adc", "tsen";
> +};
> 
