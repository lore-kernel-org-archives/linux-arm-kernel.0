From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 04 Aug 2017 17:54:27 +0300
Subject: [PATCH v3 3/6] dt-bindings: add binding for Sitronix ST7586
 display panels
In-Reply-To: <1501799630-1650-4-git-send-email-david@lechnology.com>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
 <1501799630-1650-4-git-send-email-david@lechnology.com>
Message-ID: <2434051.fAH1OaXNrL@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thank you for the patch.

On Thursday 03 Aug 2017 17:33:47 David Lechner wrote:
> This adds a new binding for Sitronix ST7586 display panels.
> 
> Using lego as the vendor prefix in the compatible string because the display
> panel I am working with is an integral part of the LEGO MINDSTORMS EV3.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/display/sitronix,st7586.txt           | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/sitronix,st7586.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/sitronix,st7586.txt
> b/Documentation/devicetree/bindings/display/sitronix,st7586.txt new file
> mode 100644
> index 0000000..dfb0b7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sitronix,st7586.txt
> @@ -0,0 +1,26 @@
> +Sitronix ST7586 display panel
> +
> +Required properties:
> +- compatible:	"lego,ev3-lcd".
> +
> +The node for this driver must be a child node of a SPI controller, hence
> +all mandatory properties described in ../spi/spi-bus.txt must be specified.
> +
> +Optional properties:
> +- dc-gpios:	D/C pin. The presence/absence of this GPIO determines
> +		the panel interface operation mode (IF[3:1] pins):
> +		- present: IF=011 4-wire 8-bit data serial interface
> +		- absent:  IF=010 3-wire 9-bit data serial interface

How does this work ? Do you have a single GPIO on your system connected to 
IF[1], with IF[3:2] hardwired to 01 ?

> +- reset-gpios:	Reset pin
> +- power-supply:	A regulator node for the supply voltage.
> +- backlight:	phandle of the backlight device attached to the panel
> +- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)

Please use the OF graph DT bindings (a.k.a. ports) to describe the connection 
between the panel and its source.

> +Example:
> +	display at 0{
> +		compatible = "lego,ev3-lcd";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +		dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
> +	};

-- 
Regards,

Laurent Pinchart
