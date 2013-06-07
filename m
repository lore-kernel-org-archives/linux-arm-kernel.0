From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:47 -0300
Subject: [PATCH 10/14] ARM: mvebu: Add BootROM to Armada 370/XP device tree
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-11-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to access the SoC BootROM, we need to declare a mapping
(through a ranges property). The mbus driver will use this property
to allocate a suitable address decoding window.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 6 ++++++
 arch/arm/boot/dts/armada-xp.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 54cd3ef..1b11f1f 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -33,6 +33,12 @@
 		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
 		ranges = <0 0 0xd0000000 0x100000>;
 
+		bootrom {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x01e00000 0xfff00000 0x100000>;
+		};
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index a3865f7..5a26d81 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -27,6 +27,12 @@
 		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
 		ranges = <0 0 0 0xd0000000 0x100000>;
 
+		bootrom {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x011d0000 0xfff00000 0x100000>;
+		};
+
 		internal-regs {
 			L2: l2-cache {
 				compatible = "marvell,aurora-system-cache";
-- 
1.8.1.5
