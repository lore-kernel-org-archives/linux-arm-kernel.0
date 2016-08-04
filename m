From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 13:25:15 -0500
Subject: [RFC PATCH v3 1/2] Documentation: DT: net: Add Xilinx
 gmiitorgmii converter device tree binding documentation
In-Reply-To: <1470312789-28275-1-git-send-email-appanad@xilinx.com>
References: <1470312789-28275-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160804182515.GA19890@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 05:43:08PM +0530, Kedareswara rao Appana wrote:
> Device-tree binding documentation for xilinx gmiitorgmii converter.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v3:
> --> None.
> Changes for v2:
> --> New patch.
> 
>  .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt b/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> new file mode 100644
> index 0000000..79fa504
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> @@ -0,0 +1,32 @@
> +XILINX GMIITORGMII Converter Driver Device Tree Bindings
> +--------------------------------------------------------
> +
> +The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
> +Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
> +Ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
> +This core can be used in all three modes of operation(10/100/1000 Mb/s).
> +The Management Data Input/Output (MDIO) interface is used to configure the
> +Speed of operation. This core can switch dynamically between the three
> +Different speed modes by configuring the conveter register through mdio write.
> +
> +The MDIO is a bus to which the PHY devices are connected.  For each
> +device that exists on this bus, a child node should be created.  See
> +the definition of the PHY node in booting-without-of.txt for an example
> +of how to define a PHY.
> +
> +Required properties:
> +  - compatible : Should be "xilinx,gmiitorgmii"

Perhaps xilinx,gmii-to-rgmii.

This needs some sort of version information in the compatible string.

> +  - reg : The ID number for the phy, usually a small integer
> +
> +Example:
> +	mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +		ethernet-phy at 0 {
> +			......
> +		};
> +                gmii_to_rgmii: gmii_to_rgmii at 8 {

Don't use underscores in node names.

> +                        compatible = "xilinx,gmiitorgmii";
> +                        reg = <8>;
> +                };
> +        };
> -- 
> 2.1.2
> 
