From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:38:17 +0000
Subject: [PATCH v2 12/28] drm/i2c: tda998x: add DT support
In-Reply-To: <20140109120324.4e2c8aca@armhf>
References: <20140109120324.4e2c8aca@armhf>
Message-ID: <20140111173817.GZ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:03:24PM +0100, Jean-Francois Moine wrote:
> diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> new file mode 100644
> index 0000000..f07339e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> @@ -0,0 +1,16 @@
> +Device-Tree bindings for the NXP TDA998x HDMI transmitter
> +
> +Required properties;
> +  - compatible: must be "nxp,tda998x"
> +
> +Optional properties:
> +  - video-ports: 24 bits value - default: <0x230145>
> +
> +Example:
> +
> +	tda998x: hdmi-encoder {
> +		compatible = "nxp,tda998x";
> +		reg = <0x70>;
> +		pinctrl-0 = <&pmx_camera>;
> +		pinctrl-names = "default";

This example seems to be meaningless.  What SoC pinctrl settings are there
on this device?  What has a HDMI encoder got to do with a camera?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
