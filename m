From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:35 -0300
Subject: [PATCH 11/15] ARM: mvebu: Enable Armada 370/XP watchdog in the
 devicetree
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-12-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes to enable watchdog support available in Armada 370
and Armada XP SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
In order to build, this commit needs:
"ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP"

 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++++
 arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..79f4fae 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -87,6 +87,10 @@
 				clocks = <&coreclk 2>;
 			};
 
+			watchdog at 20300 {
+				reg = <0x20300 0x34>;
+			};
+
 			sata at a0000 {
 				compatible = "marvell,orion-sata";
 				reg = <0xa0000 0x5000>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 8f63e8e..84d7553 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -104,6 +104,11 @@
 				interrupts = <91>;
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
index c4d1219..0eda4b9 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -65,6 +65,12 @@
 				marvell,timer-25Mhz;
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
