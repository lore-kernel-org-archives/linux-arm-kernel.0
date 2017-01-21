From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 21 Jan 2017 12:39:39 +0000
Subject: [PATCH v3 1/4] Documentation: dt-bindings: add the Amlogic Meson
 SAR ADC documentation
In-Reply-To: <20170119145822.26239-2-martin.blumenstingl@googlemail.com>
References: <20170115224221.15510-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-1-martin.blumenstingl@googlemail.com>
 <20170119145822.26239-2-martin.blumenstingl@googlemail.com>
Message-ID: <264b4c52-6298-22b0-35db-3318a05b5b93@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 14:58, Martin Blumenstingl wrote:
> This adds the devicetree binding documentation for the SAR ADC found in
> Amlogic Meson SoCs.
> Currently only the GXBB, GXL and GXM SoCs are supported.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Looks straight forward to me, but there is just enough here that I'm looking
for an Ack from Rob or Mark.

Thanks,

Jonathan
> ---
>  .../bindings/iio/adc/amlogic,meson-saradc.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> new file mode 100644
> index 000000000000..9a0bec7afc63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -0,0 +1,31 @@
> +* Amlogic Meson SAR (Successive Approximation Register) A/D converter
> +
> +Required properties:
> +- compatible:	depending on the SoC this should be one of:
> +			- "amlogic,meson-gxbb-saradc" for GXBB
> +			- "amlogic,meson-gxl-saradc" for GXL and GXM
> +		along with the generic "amlogic,meson-saradc"
> +- reg:		the physical base address and length of the registers
> +- clocks:	phandle and clock identifier (see clock-names)
> +- clock-names:	mandatory clocks:
> +			- "clkin" for the reference clock (typically XTAL)
> +			- "core" for the SAR ADC core clock
> +		optional clocks:
> +			- "sana" for the analog clock
> +			- "adc_clk" for the ADC (sampling) clock
> +			- "adc_sel" for the ADC (sampling) clock mux
> +- vref-supply:	the regulator supply for the ADC reference voltage
> +- #io-channel-cells: must be 1, see ../iio-bindings.txt
> +
> +Example:
> +	saradc: adc at 8680 {
> +		compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
> +		#io-channel-cells = <1>;
> +		reg = <0x0 0x8680 0x0 0x34>;
> +		clocks = <&xtal>,
> +			 <&clkc CLKID_SAR_ADC>,
> +			 <&clkc CLKID_SANA>,
> +			 <&clkc CLKID_SAR_ADC_CLK>,
> +			 <&clkc CLKID_SAR_ADC_SEL>;
> +		clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
> +	};
> 
