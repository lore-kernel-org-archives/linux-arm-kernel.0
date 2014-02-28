From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Feb 2014 15:59:37 +0000
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20140228155937.GQ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 02:20:10PM +0200, Tomi Valkeinen wrote:
> Add DT binding documentation for DVI Connector.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
> new file mode 100644
> index 000000000000..6a0aff866c78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
> @@ -0,0 +1,26 @@
> +DVI Connector
> +==============
> +
> +Required properties:
> +- compatible: "dvi-connector"
> +
> +Optional properties:
> +- label: a symbolic name for the connector
> +- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> +
> +Required nodes:
> +- Video port for DVI input
> +
> +Example
> +-------
> +
> +dvi0: connector at 0 {
> +	compatible = "dvi-connector";
> +	label = "dvi";
> +
> +	i2c-bus = <&i2c3>;
> +
> +	dvi_connector_in: endpoint {
> +		remote-endpoint = <&tfp410_out>;
> +	};
> +};

This looks far too simplistic.  There are different classes of DVI
connector - there is:

DVI A - analogue only
DVI D - digital only (single and dual link)
DVI I - both (single and dual digital link)

DRM at least makes a distinction between these three classes, and this
disctinction is part of the user API.  How would a display system know
which kind of DVI connector is wired up on the board from this DT
description?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
