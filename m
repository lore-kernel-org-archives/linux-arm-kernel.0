From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 1 Feb 2018 09:39:11 +0200
Subject: [PATCHv2] tlv320dac33: Add device tree bindings
In-Reply-To: <20180131190112.GA31608@amd>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
Message-ID: <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-01-31 21:01, Pavel Machek wrote:
> 
> This adds device tree bindings for tlv320dac33.c.

Can you CC me for dac33 patches in the future, please?

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> new file mode 100644
> index 0000000..7fdda95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> @@ -0,0 +1,32 @@
> +Texas Instruments - tlv320dac33 Codec module
> +
> +The tlv320dac33 serial control bus communicates through I2C protocols.
> +
> +Required properties:
> +
> +- compatible - "ti,tlv320dac33"
> +- reg - I2C slave address
> +
> +Optional properties:
> +
> +- reset-gpios - gpio pin to power the device, active low
> +
> +- interrupts       - The interrupt output from the device.
> +- interrupt-parent - The parent interrupt controller.
> +
> +- ti,keep-bclk 	- Keep the BCLK running in FIFO modes
> +- ti,burst-bclkdiv - BCLK divider value in burst mode
> +
> +Example:
> +
> +tlv320dac33: audio-codec at 19 {
> +	compatible = "ti,tlv320dac33";
> +	reg = <0x19>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
> +	reset-gpios = <&gpio2 28 0>; /* gpio_60 */
> +
> +	ti,keep-bclk;
> +	ti,burst-bclkdiv = <3>;
> +};
> 
> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
