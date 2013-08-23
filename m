From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 08:53:17 +0200
Subject: [PATCH 12/12] ARM: dts: mvebu: Add a new set of registers to the PMSU
 node
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1377240797-4047-13-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. This new set of registers is needed for the CPU idle
implementation for the Armada XP, it allows to enter in a deep CPU
idle state where the Coherency Fabric and the L2 cache are powerdown.

Cc: devicetree at vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt | 12 +++++++-----
 arch/arm/boot/dts/armada-xp.dtsi                             |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
index 926b4d6..8a9db0c 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -7,14 +7,16 @@ Required properties:
 - compatible: "marvell,armada-370-xp-pmsu"
 
 - reg: Should contain PMSU registers location and length. First pair
-  for the per-CPU SW Reset Control registers, second pair for the
-  Power Management Service Unit.
+  for the per-CPU SW Reset Control registers, second pair for the CPU
+  Power Management Service Unit registers, third pair for the Fabric Power
+  Management Service Unit registers.
 
 Example:
 
-armada-370-xp-pmsu at d0022000 {
+armada-370-xp-pmsu at 22000 {
 	compatible = "marvell,armada-370-xp-pmsu";
-	reg = <0xd0022100 0x430>,
-	      <0xd0020800 0x20>;
+	reg = <0x22100 0x430>,
+	      <0x20800 0x20>,
+	      <0x22000 0x24>;
 };
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 416eb94..b58171a 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -41,7 +41,7 @@
 
 			armada-370-xp-pmsu at 22000 {
 				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x430>, <0x20800 0x20>;
+				reg = <0x22100 0x430>, <0x20800 0x20>, <0x22000 0x24>;
 			};
 
 			serial at 12200 {
-- 
1.8.1.2
