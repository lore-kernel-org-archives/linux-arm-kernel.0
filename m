From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Mar 2014 15:22:10 +0100
Subject: [PATCH 6/9] Doc/DT: Add DT binding documentation for MIPI DSI CM
 Panel
In-Reply-To: <1393590016-9361-7-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-7-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <4670830.fkS1noPxcd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

Thank you for the patch.

On Friday 28 February 2014 14:20:13 Tomi Valkeinen wrote:
> Add DT binding documentation for MIPI DSI Command Mode Panel.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/panel-dsi-cm.txt     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
> b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt new file mode
> 100644
> index 000000000000..73f422556d4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
> @@ -0,0 +1,26 @@
> +Generic MIPI DSI Command Mode Panel
> +===================================
> +
> +Required properties:
> +- compatible: "panel-dsi-cm"
> +
> +Optional properties:
> +- label: a symbolic name for the panel
> +- gpios: panel reset gpio and TE gpio
> +
> +Required nodes:
> +- Video port for DSI input
> +
> +Example
> +-------
> +
> +lcd0: display {
> +	compatible = "tpo,taal", "panel-dsi-cm";
> +	label = "lcd0";
> +
> +	gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */

If the panel uses a TE GPIO but no reset GPIO, do you plan to express this 
with a "hole" for the reset GPIO ? e.g. something like

	gpios = <0>, <&gpio4 6 GPIO_ACTIVE_HIGH>;

Wouldn't it be better to split the gpios property into "reset-gpios" and "te-
gpios" ?

> +
> +	lcd0_in: endpoint {
> +		remote-endpoint = <&dsi1_out_ep>;
> +	};
> +};

-- 
Regards,

Laurent Pinchart
