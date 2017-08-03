From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 14:03:51 -0500
Subject: [PATCH v2 1/6] dt-bindings: phy: Add documentation for NS2 USB3
 PHY
In-Reply-To: <1501109787-15489-2-git-send-email-jon.mason@broadcom.com>
References: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
 <1501109787-15489-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170803190351.x7ed626agwpcakte@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 06:56:22PM -0400, Jon Mason wrote:
> From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> 
> Add documentation for USB3 PHY available in NS2 SoC
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  .../devicetree/bindings/phy/brcm,ns2-usb3-phy.txt  | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt b/Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
> new file mode 100644
> index 000000000000..b1c058c37d54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,ns2-usb3-phy.txt
> @@ -0,0 +1,48 @@
> +Broadcom USB3 dual port phy for Northstar2 SoC
> +This is a child bus node of "brcm,mdio-mux-iproc" node.
> +
> +Required mdio bus properties:
> +- reg: MDIO Bus number for the MDIO interface
> +- #address-cells: must be 1
> +- #size-cells: must be 0
> +
> +Required PHY properties:
> +- compatible: should be "brcm,ns2-usb3-phy"
> +- reg: MDIO Phy ID for the MDIO interface
> +- #phy-cells: must be 0
> +- #address-cells: must be 1
> +- #size-cells: must be 0
> +
> +Sub-nodes:
> +  Each port's PHY should be represented as a sub-node.
> +
> +Sub-nodes required properties:
> + - reg: the PHY number
> + - phy-cells: from the generic PHY bindings, must be 0
> +
> +Example:
> +
> +mdio at 1 {
> +	reg = <0x1>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	usb3_phy: usb3_phy at 0 {

usb3-phy at 0

> +		compatible = "brcm,ns2-usb3-phy";
> +		reg = <0x0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb3_phy0: usb3_phy at 0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +			status = "disabled";

Don't show status in examples.

With those nits fixed,

Acked-by: Rob Herring <robh@kernel.org>


> +		};
> +
> +		usb3_phy1: usb_phy at 1 {
> +			reg = <1>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +	};
> +};
> -- 
> 2.7.4
> 
