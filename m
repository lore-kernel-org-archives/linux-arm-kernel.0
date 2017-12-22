From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 22 Dec 2017 14:08:20 +0200
Subject: [PATCH v5 01/12] dt-bindings: panel: lvds: Document power-supply
 property
In-Reply-To: <0a6a3abcf1a6b7f0e66a81af8a44c5c0566ce06c.1513854122.git-series.maxime.ripard@free-electrons.com>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
 <0a6a3abcf1a6b7f0e66a81af8a44c5c0566ce06c.1513854122.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2493504.1OPucrC18r@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Thursday, 21 December 2017 13:02:27 EET Maxime Ripard wrote:
> The power-supply property is used by a vast majority of panels, including
> panel-simple. Let's document it as a common property
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-common.txt | 6 ++++++
> Documentation/devicetree/bindings/display/panel/panel-lvds.txt   | 1 +
> Documentation/devicetree/bindings/display/panel/simple-panel.txt | 2 +- 3
> files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> b/Documentation/devicetree/bindings/display/panel/panel-common.txt index
> ec52c472c845..125ea68052af 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> @@ -78,6 +78,12 @@ used for panels that implement compatible control
> signals. while active. Active high reset signals can be supported by
> inverting the GPIO specifier polarity flag.
> 
> +Power
> +-----
> +
> +- power-supply: many display panels need an additional power supply in
> +  order to be fully powered-up. For such panels, power-supply contains
> +  a phandle to the regulator powering the panel.

I think we should give more details here about the limitations of this 
property. How about the following explanation ?

- power-supply: display panels require power to be supplied. While several 
panels need more than one power supply with panel-specific constraints 
governing the order and timings of the power supplies, in many cases a single 
power supply is sufficient, either because the panel has a single power rail, 
or because all its power rails can be driven by the same supply. In that case 
the power-supply property specifies the supply powering the panel as a phandle 
to a regulator.

>  Backlight
>  ---------
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
> b/Documentation/devicetree/bindings/display/panel/panel-lvds.txt index
> b938269f841e..250850a2150b 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.txt
> @@ -32,6 +32,7 @@ Optional properties:
>  - label: See panel-common.txt.
>  - gpios: See panel-common.txt.
>  - backlight: See panel-common.txt.
> +- power-supply: See panel-common.txt.
>  - data-mirror: If set, reverse the bit order described in the data mappings
> below on all data lanes, transmitting bits for slots 6 to 0 instead of 0 to
> 6.
> diff --git
> a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> b/Documentation/devicetree/bindings/display/panel/simple-panel.txt index
> 1341bbf4aa3d..16d8ff088b7d 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -1,7 +1,7 @@
>  Simple display panel
> 
>  Required properties:
> -- power-supply: regulator to provide the supply voltage
> +- power-supply: See panel-common.txt
> 
>  Optional properties:
>  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing

-- 
Regards,

Laurent Pinchart
