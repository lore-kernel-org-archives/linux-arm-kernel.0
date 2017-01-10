From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 10 Jan 2017 23:06:22 +0200
Subject: [PATCH V7 1/4] Documentation/devicetree/bindings: b850v3_lvds_dp
In-Reply-To: <21ea1b0795bdaa30ca475d6ce675b620b2b644ed.1483301745.git.peter.senna@collabora.com>
References: <cover.1483301745.git.peter.senna@collabora.com>
 <21ea1b0795bdaa30ca475d6ce675b620b2b644ed.1483301745.git.peter.senna@collabora.com>
Message-ID: <6121545.d1oTkZXUdh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thank you for the patch.

On Sunday 01 Jan 2017 21:24:29 Peter Senna Tschudin wrote:
> Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> display bridge.
> 
> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> Cc: Martin Donnelly <martin.donnelly@ge.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> There was an Acked-by from Rob Herring <robh@kernel.org> for V6, but I
> changed the bindings to use i2c_new_secondary_device() so I removed it from
> the commit message.
> 
>  .../devicetree/bindings/ge/b850v3-lvds-dp.txt      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
> 
> diff --git a/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
> b/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt new file mode
> 100644
> index 0000000..1bc6ebf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
> @@ -0,0 +1,39 @@
> +Driver for GE B850v3 LVDS/DP++ display bridge
> +
> +Required properties:
> +  - compatible : should be "ge,b850v3-lvds-dp".
> +  - reg : should contain the main address which is used to ack the
> +    interrupts and address for edid.
> +  - reg-names : comma separeted list of register names. Valid values
> +    are "main", and "edid".
> +  - interrupt-parent : phandle of the interrupt controller that services
> +    interrupts to the device
> +  - interrupts : one interrupt should be described here, as in
> +    <0 IRQ_TYPE_LEVEL_HIGH>.
> +  - port : should describe the video signal connection between the host
> +    and the bridge.

A bridge has, by definition, (at least) one input and (at least) one output. 
You should thus have (at least) two ports.

> +Example:
> +
> +&mux2_i2c2 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	b850v3-lvds-dp-bridge at 73  {
> +		compatible = "ge,b850v3-lvds-dp";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg = <0x73 0x72>;
> +		reg-names = "main", "edid";
> +
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		port {
> +			b850v3_dp_bridge_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart
