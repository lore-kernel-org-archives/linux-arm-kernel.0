From: peter.senna@collabora.co.uk (Peter Senna Tschudin)
Date: Mon, 26 Sep 2016 09:27:59 +0100
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?= V5 =?utf-8?q?4=2F4=5D?=
 =?utf-8?q?_dts=2Fimx6q-b850v3=3A?= Use GE B850v3 =?utf-8?q?LVDS=2FDP++?=
 Bridge
In-Reply-To: <61b63c6a5fec9fce0332e5e9db676e6b6a6fc180.1470739193.git.peter.senna@collabora.com>
Message-ID: <137a-57e8dc00-1-42b5770@58989149>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1/4 is already on linux-next, but what about this one? Ping?

On Tuesday, August 9, 2016 18:41 CEST, Peter Senna Tschudin <peter.senna@collabora.com> wrote: 
 
> Configures the GE B850v3 LVDS/DP++ bridge on the dts file.
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
> Unchanged from V4
> 
> Changes from V3:
>  - 4/4 instead of 5/5
> 
> Unchanged from V2
> 
> Changes from V1:
>  - Replaced '_' by '-' in node names or compatible strings
>  - Added missing @73 to b850v3-lvds-dp-bridge
> 
>  arch/arm/boot/dts/imx6q-b850v3.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
> index 167f744..8db3bf2 100644
> --- a/arch/arm/boot/dts/imx6q-b850v3.dts
> +++ b/arch/arm/boot/dts/imx6q-b850v3.dts
> @@ -72,6 +72,13 @@
>  		fsl,data-mapping = "spwg";
>  		fsl,data-width = <24>;
>  		status = "okay";
> +
> +		port at 4 {
> +			reg = <4>;
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&b850v3_lvds_dp_bridge_in>;
> +			};
> +		};
>  	};
>  };
>  
> @@ -142,3 +149,26 @@
>  		reg = <0x4a>;
>  	};
>  };
> +
> +&mux2_i2c2 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	b850v3-lvds-dp-bridge at 73 {
> +		compatible = "ge,b850v3-lvds-dp";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg = <0x73>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		edid-reg = <0x72>;
> +
> +		port {
> +			b850v3_lvds_dp_bridge_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.5.5
> 
 
 
 
 
