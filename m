From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  1 Dec 2017 12:25:03 +0100
Subject: [PATCH 1/6] dt-bindings: marvell: Add documentation for the North
 Bridge PM on Armada 37xx
In-Reply-To: <20171201112508.14121-1-gregory.clement@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Message-ID: <20171201112508.14121-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the documentation of the Armada 37xx SoC with the the North
Bridge Power Management component.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell/armada-37xx.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
index 51336e5fc761..7ad9830d9177 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -14,3 +14,22 @@ following property before the previous one:
 Example:
 
 compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
+
+
+Power management
+----------------
+
+For power management (particularly DVFS and AVS), the North Bridge
+Power Management component is needed:
+
+Required properties:
+- compatible     : should contain "marvell,armada-3700-nb-pm", "syscon";
+- reg            : the register start and length for the North Bridge
+		    Power Management
+
+Example:
+
+nb_pm: nb_pm at 14000 {
+	compatible = "marvell,armada-3700-nb-pm", "syscon";
+	reg = <0x14000 0x60>;
+}
-- 
2.15.0
