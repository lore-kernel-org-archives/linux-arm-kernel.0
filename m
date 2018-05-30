From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 May 2018 15:36:29 +0300
Subject: [PATCH v2 07/10] dt-bindings: tc358754: add DT bindings
In-Reply-To: <1527682561-1386-8-git-send-email-m.purski@samsung.com>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
 <CGME20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9@eucas1p1.samsung.com>
 <1527682561-1386-8-git-send-email-m.purski@samsung.com>
Message-ID: <6047372.VZe6FOdiCA@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

On Wednesday, 30 May 2018 15:15:58 EEST Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
> Bindings describe power supplies, reset gpio and video interfaces.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/bridge/toshiba,tc358764.txt   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt new
> file mode 100644
> index 0000000..6eda14f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> @@ -0,0 +1,37 @@
> +TC358764 MIPI-DSI to LVDS panel bridge
> +
> +Required properties:
> +  - compatible: "toshiba,tc358764"
> +  - reg: the virtual channel number of a DSI peripheral
> +  - vddc-supply: core voltage supply, 1.2V
> +  - vddio-supply: I/O voltage supply, 1.8V or 3.3V
> +  - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
> +  - reset-gpios: a GPIO spec for the reset pin
> +
> +The device node can contain zero to two 'port' child nodes, each with one
> +child 'endpoint' node, according to the bindings defined in [1].
> +The following are properties specific to those nodes.
> +
> +port:
> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt

Could you please take the comments I made on v1 into account when you'll post 
v3 ?

> +Example:
> +
> +	bridge at 0 {
> +		reg = <0>;
> +		compatible = "toshiba,tc358764";
> +		vddc-supply = <&vcc_1v2_reg>;
> +		vddio-supply = <&vcc_1v8_reg>;
> +		vddlvds-supply = <&vcc_3v3_reg>;
> +		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port at 1 {
> +			reg = <1>;
> +			lvds_ep: endpoint {
> +				remote-endpoint = <&panel_ep>;
> +			};
> +		};
> +	};


-- 
Regards,

Laurent Pinchart
