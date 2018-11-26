From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Sun, 25 Nov 2018 18:15:24 -0600
Subject: [PATCH linux-next 03/10] dt-bindings: net: ti: cpsw: switch to use
 phy-gmii-sel phy
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Message-ID: <20181126001531.12974-4-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
deprecate cpsw-phy-sel bindings and update CPSW binding to use phy-gmii-sel
PHY bindings.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index b3acebe..3264e19 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -22,7 +22,8 @@ Required properties:
 - cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
 			  device. See also cpsw-phy-sel.txt for it's binding.
 			  Note that in legacy cases cpsw-phy-sel may be
-			  a child device instead of a phandle.
+			  a child device instead of a phandle
+			  (DEPRECATED, use phys property instead).
 
 Optional properties:
 - ti,hwmods		: Must be "cpgmac0"
@@ -44,6 +45,7 @@ Optional properties:
 Slave Properties:
 Required properties:
 - phy-mode		: See ethernet.txt file in the same directory
+- phys			: phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
 
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
@@ -85,12 +87,14 @@ Examples:
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 1 0>;
 		};
 		cpsw_emac1: slave at 1 {
 			phy_id = <&davinci_mdio>, <1>;
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 2 0>;
 		};
 	};
 
@@ -114,11 +118,13 @@ Examples:
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 1 0>;
 		};
 		cpsw_emac1: slave at 1 {
 			phy_id = <&davinci_mdio>, <1>;
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 2 0>;
 		};
 	};
-- 
2.10.5
