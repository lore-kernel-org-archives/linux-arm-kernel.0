From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Oct 2018 15:58:55 -0500
Subject: [PATCH v4 07/10] dt-bindings: phy: add binding for Allwinner
 USB3 PHY
In-Reply-To: <20181004122855.22981-8-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-8-icenowy@aosc.io>
Message-ID: <20181005205855.GA2458@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 08:28:52PM +0800, Icenowy Zheng wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
> 
> Add a device tree binding for the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Changed Vbus regulator property to vbus-supply.
> 
> Changes in v3:
> - Added Chen-Yu's Review tag.
> 
> No changes in v2, v1.
> 
>  .../bindings/phy/sun50i-usb3-phy.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..9f49c6b8c7e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,23 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional Properties:
> +- vbus-supply : a phandle to a regulator that provides power to VBUS.

This belongs in a connector node as it is part of the connector unless 
the phy physically needs Vbus for power.

But others have done this, so all the phys can just be wrong...

> +
> +Example:
> +	usb3phy: phy at 5210000 {

usb-phy@

> +		compatible = "allwinner,sun50i-h6-usb3-phy";
> +		reg = <0x5210000 0x10000>;
> +		clocks = <&ccu CLK_USB_PHY1>;
> +		resets = <&ccu RST_USB_PHY1>;
> +		#phy-cells = <0>;
> +		status = "disabled";

Don't show status in examples.

> +	};
> -- 
> 2.18.0
> 
