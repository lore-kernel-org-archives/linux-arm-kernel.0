From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 06:12:38 -0300
Subject: [PATCH v2 12/15] ARM: mvebu: Enable Armada 370/XP watchdog in the
 devicetree
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390295561-3466-13-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes to enable watchdog support available in Armada 370
and Armada XP SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++++
 arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7f10f62..96e0389 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -151,6 +151,10 @@
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			};
 
+			watchdog at 20300 {
+				reg = <0x20300 0x34>, <0x20704 0x4>;
+			};
+
 			sata at a0000 {
 				compatible = "marvell,orion-sata";
 				reg = <0xa0000 0x5000>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 7a4b82e..aebed9e 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -168,6 +168,11 @@
 				clocks = <&coreclk 2>;
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,armada-370-wdt";
+				clocks = <&coreclk 2>;
+			};
+
 			coreclk: mvebu-sar at 18230 {
 				compatible = "marvell,armada-370-core-clock";
 				reg = <0x18230 0x08>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 281c644..8c6c06c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -74,6 +74,12 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,armada-xp-wdt";
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
 			coreclk: mvebu-sar at 18230 {
 				compatible = "marvell,armada-xp-core-clock";
 				reg = <0x18230 0x08>;
-- 
1.8.1.5
