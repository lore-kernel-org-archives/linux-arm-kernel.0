From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Feb 2014 14:40:36 +0100
Subject: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI
 Panel
In-Reply-To: <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1393594836.3802.32.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
> Add DT binding documentation for MIPI DPI Panel.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/panel-dpi.txt        | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Documentation/devicetree/bindings/video/panel-dpi.txt
> new file mode 100644
> index 000000000000..72636c6f1c67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
> @@ -0,0 +1,43 @@
> +Generic MIPI DPI Panel
> +======================
> +
> +Required properties:
> +- compatible: "panel-dpi"
> +
> +Optional properties:
> +- label: a symbolic name for the panel
> +- gpios: panel enable gpio and backlight enable gpio
> +
> +Required nodes:
> +- "panel-timing" containing video timings
> +  (Documentation/devicetree/bindings/video/display-timing.txt)
> +- Video port for DPI input

I don't see anything MIPI specific here. Couldn't this be added to the
existing simple-panel binding?

> +Example
> +-------
> +
> +lcd0: display at 0 {
> +        compatible = "samsung,lte430wq-f0c", "panel-dpi";
> +        label = "lcd";
> +
> +        lcd_in: endpoint {
> +                remote-endpoint = <&dpi_out>;
> +        };
> +
> +        panel-timing {
> +                clock-frequency = <9200000>;
> +                hactive = <480>;
> +                vactive = <272>;
> +                hfront-porch = <8>;
> +                hback-porch = <4>;
> +                hsync-len = <41>;
> +                vback-porch = <2>;
> +                vfront-porch = <4>;
> +                vsync-len = <10>;
> +
> +                hsync-active = <0>;
> +                vsync-active = <0>;
> +                de-active = <1>;
> +                pixelclk-active = <1>;
> +        };
> +};

regards
Philipp
