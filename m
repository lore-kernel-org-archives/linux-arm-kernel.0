From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Mar 2014 17:26:46 +0100
Subject: [PATCH v9][ 7/8] ARM: dts: mbimx51sd: Add display support.
In-Reply-To: <1394121869-13387-4-git-send-email-denis@eukrea.com>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-1-git-send-email-denis@eukrea.com>
 <1394121869-13387-4-git-send-email-denis@eukrea.com>
Message-ID: <1394123206.3622.51.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

Am Donnerstag, den 06.03.2014, 17:04 +0100 schrieb Denis Carikli:
[...]
> +&display {
> +	status = "okay";
> +	display-timings {
> +		model = "DVI-SVGA";

Does this board really have a DVI connector and no I2C bus routed to the
DDC pins?

> +		bits-per-pixel = <16>;
> +		svga {
> +			clock-frequency = <44333333>;
> +			hactive = <800>;
> +			vactive = <600>;
> +			hback-porch = <112>;
> +			hfront-porch = <32>;
> +			vback-porch = <3>;
> +			vfront-porch = <17>;
> +			hsync-len = <80>;
> +			vsync-len = <4>;
> +			hsync-active = <1>;
> +			vsync-active = <1>;
> +			de-active = <1>;
> +			pixelclk-active = <1>;
> +		};
> +	};
> +};
[...] 
> +	imx_drm: imx-drm {
> +		compatible = "fsl,imx-drm";
> +		crtcs = <&ipu 0>;
> +		connectors = <&display>;
> +		status = "disabled";
> +	};

Please let's postpone this until the imx-drm-dt patch series is
accepted. I've changed the device tree bindings so this node
is not necessary to be included in every board dts.

regards
Philipp
