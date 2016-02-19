From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 19 Feb 2016 10:13:30 +0100
Subject: [PATCH v10 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
In-Reply-To: <1455870678-13959-1-git-send-email-jitao.shi@mediatek.com>
References: <1455870678-13959-1-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1455873210.13163.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 19.02.2016, 16:31 +0800 schrieb Jitao Shi:
> Add documentation for DT properties supported by
> ps8640 DSI-eDP converter.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v9:
>  - No change
> ---
>  .../devicetree/bindings/display/bridge/ps8640.txt  |   43 ++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.txt b/Documentation/devicetree/bindings/display/bridge/ps8640.txt
> new file mode 100644
> index 0000000..a3e0971
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ps8640.txt
> @@ -0,0 +1,43 @@
> +ps8640-bridge bindings
> +
> +Required properties:
> +	- compatible: "parade,ps8640"
> +	- reg: first page address of the bridge.
> +	- sleep-gpios: OF device-tree gpio specification for PD_ pin.
> +	- reset-gpios: OF device-tree gpio specification for reset pin.
> +	- mode-sel-gpios: OF device-tree gpio specification for mode-sel pin.
> +	- vdd12-supply: OF device-tree regulator specification for 1.2V power.
> +	- vdd33-supply: OF device-tree regulator specification for 3.3V power.
> +	- ports: The device node can contain video interface port nodes per
> +		 the video-interfaces bind[1]. For port at 0,set the reg = <0> as
> +		 ps8640 dsi in and port at 1,set the reg = <1> as ps8640 eDP out.
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +	edp-bridge at 18 {
> +		compatible = "parade,ps8640";
> +		reg = <0x18>;
> +		sleep-gpios = <&pio 116 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pio 115 GPIO_ACTIVE_HIGH>;

Are these two really active high? See my comments on the driver patch.

regards
Philipp
