From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:09 -0300
Subject: [PATCH v3 02/28] ARM: mvebu: Add Core Divider clock device-tree
 binding
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370/XP SoCs have a Core Divider clock providing
several clocks. For now, only the NAND clock is supported.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-corediv-clock.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
new file mode 100644
index 0000000..c62391f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
@@ -0,0 +1,19 @@
+* Core Divider Clock bindings for Marvell MVEBU SoCs
+
+The following is a list of provided IDs and clock names on Armada 370/XP:
+ 0 = nand (NAND clock)
+
+Required properties:
+- compatible : must be "marvell,armada-370-corediv-clock"
+- reg : must be the register address of Core Divider control register
+- #clock-cells : from common clock binding; shall be set to 1
+- clocks : must be set to the parent's phandle
+
+Example:
+
+corediv_clk: corediv-clocks at 18740 {
+	compatible = "marvell,armada-370-corediv-clock";
+	reg = <0x18740 0xc>;
+	#clock-cells = <1>;
+	clocks = <&pll>;
+};
-- 
1.8.1.5
