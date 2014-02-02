From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:49:12 +0100
Subject: [PATCH 2/3] net: phy: sunxi: Add new compatibles
In-Reply-To: <1391348953-10662-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391348953-10662-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391348953-10662-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Add compatibles
matching the other pattern to the mdio driver for consistency, and keep the
older one for backward compatibility.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/net/allwinner,sun4i-mdio.txt | 5 +++--
 drivers/net/phy/mdio-sun4i.c                                   | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun4i-mdio.txt b/Documentation/devicetree/bindings/net/allwinner,sun4i-mdio.txt
index 00b9f9a..4ec5641 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun4i-mdio.txt
+++ b/Documentation/devicetree/bindings/net/allwinner,sun4i-mdio.txt
@@ -1,7 +1,8 @@
 * Allwinner A10 MDIO Ethernet Controller interface
 
 Required properties:
-- compatible: should be "allwinner,sun4i-mdio".
+- compatible: should be "allwinner,sun4i-a10-mdio"
+              (Deprecated: "allwinner,sun4i-mdio").
 - reg: address and length of the register set for the device.
 
 Optional properties:
@@ -9,7 +10,7 @@ Optional properties:
 
 Example at the SoC level:
 mdio at 01c0b080 {
-	compatible = "allwinner,sun4i-mdio";
+	compatible = "allwinner,sun4i-a10-mdio";
 	reg = <0x01c0b080 0x14>;
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/drivers/net/phy/mdio-sun4i.c b/drivers/net/phy/mdio-sun4i.c
index 18969b3..7f4a66d 100644
--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -171,6 +171,9 @@ static int sun4i_mdio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_mdio_dt_ids[] = {
+	{ .compatible = "allwinner,sun4i-a10-mdio" },
+
+	/* Deprecated */
 	{ .compatible = "allwinner,sun4i-mdio" },
 	{ }
 };
-- 
1.8.4.2
