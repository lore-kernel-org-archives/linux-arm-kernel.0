From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jan 2015 11:36:59 +0000
Subject: [PATCH v2 12/12] dt-bindings: Add documentation for Rockchip
 dw-hdmi-audio
In-Reply-To: <1422618253-27312-1-git-send-email-ykk@rock-chips.com>
References: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
 <1422618253-27312-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20150131113659.GA26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 06:44:13AM -0500, Yakir Yang wrote:
> Required properties:
> - compatible: platform specific
> - cpu-of-node: the device node of cpu_dai
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v2:
> - remove codec-name and codec-dai-name
> - rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt
> 
>  .../bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
> new file mode 100644
> index 0000000..5b86eed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
> @@ -0,0 +1,12 @@
> +Rockchip hdmi audio bindings
> +
> +Required properties:
> +- compatible: platform specific
> +- cpu-of-node: the device node of cpu_dai
> +
> +Example:
> +
> +sound {
> +	compatible = "rockchip,rk3288-hdmi-audio";
> +	cpu-of-node = <&i2s>;
> +};

In patch 11, it looks like you parse a property called i2s-controller.
This doesn't appear to be documented.  Maybe it's what you call
"cpu-of-node" above?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
