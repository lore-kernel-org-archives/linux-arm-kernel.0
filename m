From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Feb 2014 14:38:27 +0100
Subject: [PATCH 7/9] Doc/DT: Add DT binding documentation for Sony
 acx565akm panel
In-Reply-To: <1393590016-9361-8-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-8-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1393594707.3802.31.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
> Add DT binding documentation for Sony acx565akm panel
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Sebastian Reichel <sre@debian.org>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/sony,acx565akm.txt   | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/sony,acx565akm.txt b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
> new file mode 100644
> index 000000000000..cd9cfdf7e3fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
> @@ -0,0 +1,28 @@
> +Sony ACX565AKM SDI Panel
> +========================
> +
> +Required properties:
> +- compatible: "sony,acx565akm"
> +
> +Optional properties:
> +- label: a symbolic name for the panel
> +- gpios: panel reset gpio

please let's call this reset-gpios.

> +Required nodes:
> +- Video port for SDI input
> +
> +Example
> +-------
> +
> +acx565akm at 2 {
> +	compatible = "sony,acx565akm";
> +	spi-max-frequency = <6000000>;
> +	reg = <2>;
> +
> +	label = "lcd";
> +	gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
> +
> +	lcd_in: endpoint {
> +		remote-endpoint = <&sdi_out>;
> +	};
> +};

regards
Philipp
