From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 16:51:57 -0500
Subject: [PATCH v4 2/3] media: ov7740: Document device tree bindings
In-Reply-To: <20171031011146.6899-3-wenyou.yang@microchip.com>
References: <20171031011146.6899-1-wenyou.yang@microchip.com>
 <20171031011146.6899-3-wenyou.yang@microchip.com>
Message-ID: <20171101215157.5hemcpuplikvtpqx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 09:11:44AM +0800, Wenyou Yang wrote:
> Add the device tree binding documentation for the ov7740 sensor driver.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
>  - Explicitly document the "remote-endpoint" property.
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/media/i2c/ov7740.txt       | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov7740.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov7740.txt b/Documentation/devicetree/bindings/media/i2c/ov7740.txt
> new file mode 100644
> index 000000000000..af781c3a5f0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ov7740.txt
> @@ -0,0 +1,47 @@
> +* Omnivision OV7740 CMOS image sensor
> +
> +The Omnivision OV7740 image sensor supports multiple output image
> +size, such as VGA, and QVGA, CIF and any size smaller. It also
> +supports the RAW RGB and YUV output formats.
> +
> +The common video interfaces bindings (see video-interfaces.txt) should
> +be used to specify link to the image data receiver. The OV7740 device
> +node should contain one 'port' child node with an 'endpoint' subnode.
> +
> +Required Properties:
> +- compatible:	"ovti,ov7740".
> +- reg:		I2C slave address of the sensor.
> +- clocks:	Reference to the xvclk input clock.
> +- clock-names:	"xvclk".
> +
> +Optional Properties:
> +- reset-gpios: Rreference to the GPIO connected to the reset_b pin,
> +  if any. Active low with pull-ip resistor.
> +- powerdown-gpios: Reference to the GPIO connected to the pwdn pin,
> +  if any. Active high with pull-down resistor.
> +
> +Endpoint node mandatory properties:
> +- remote-endpoint: A phandle to the bus receiver's endpoint node.

This is not really necessary. What's required is documenting how many 
ports and how many endpoints for each port which you have above.

Acked-by: Rob Herring <robh@kernel.org>
