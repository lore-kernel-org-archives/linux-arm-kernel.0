From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 25 Sep 2013 18:28:19 -0300
Subject: [PATCH 2/5] ARM: mvebu: Add Core Divider clock device-tree binding
In-Reply-To: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1380144502-24109-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370/XP SoCs have a Core Divider clock providing
several clocks. For now, only the NAND clock is supported.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-corediv-clock.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
new file mode 100644
index 0000000..ea60f4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
@@ -0,0 +1,19 @@
+* Core Divider Clock bindings for Marvell MVEBU SoCs
+
+The following is a list of provided IDs and clock names on Armada 370/XP:
+ 0 = nand_ecc   (NAND ECC clock)
+
+Required properties:
+- compatible : must be "marvell,armada-370-corediv-clock"
+- reg : must be the register address of Core Divider control register
+- #clock-cells : from common clock binding; shall be set to 1
+- #clocks : must be set to the parent's phandle
+
+Example:
+
+corediv_clk: corediv-clocks at 18740 {
+	compatible = "marvell,armada-370-corediv-clock";
+	reg = <0x18740 0x8>;
+	#clock-cells = <1>;
+	clocks = <&pll>;
+};
-- 
1.8.1.5
