From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 30 Aug 2018 21:01:13 +0200
Subject: [PATCH v4 06/13] dt-bindings: ata: update ahci_sunxi bindings
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Message-ID: <20180830190120.722-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since phy code is moved from ahci_sunxi to a dedicated driver, the
binding need to be updated with the new phy node requirement.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index f495774c8af9..aa6f4c745097 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -50,6 +50,14 @@ And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
 - target-supply     : regulator for SATA target power
 
+Required properties for:
+* allwinner,sun4i-a10-ahci
+* allwinner,sun8i-r40-ahci
+A port sub-node must be present and linked to a sata_phy.
+
+Required properties for allwinner,sun8i-r40-ahci
+The reset and ahci-supply properties must be present.
+
 Examples:
         sata at ffe08000 {
 		compatible = "snps,spear-ahci";
-- 
2.16.4
