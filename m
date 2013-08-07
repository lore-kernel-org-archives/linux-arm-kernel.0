From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  7 Aug 2013 20:52:36 -0300
Subject: [PATCH 5/5] ARM: mvebu: Fix the Armada 370/XP timer compatible strings
In-Reply-To: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1375919556-24104-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "marvell,armada-370-xp-timer" compatible string, together with
the "marvell,timer-25Mhz" property are deprecated and should be
removed from current DT.

Instead, the timer DT nodes are now required to have an appropriate
compatible string, which should be either "marvell,armada-370-timer"
or "marvell,armada-xp-timer", depending on SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 -
 arch/arm/boot/dts/armada-370.dtsi    | 4 ++++
 arch/arm/boot/dts/armada-xp.dtsi     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..3ed5de4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -81,7 +81,6 @@
 			};
 
 			timer at 20300 {
-				compatible = "marvell,armada-370-xp-timer";
 				reg = <0x20300 0x30>, <0x21040 0x30>;
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 				clocks = <&coreclk 2>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..f7b9fc6 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -104,6 +104,10 @@
 				interrupts = <91>;
 			};
 
+			timer at 20300 {
+				compatible = "marvell,armada-370-timer";
+			};
+
 			coreclk: mvebu-sar at 18230 {
 				compatible = "marvell,armada-370-core-clock";
 				reg = <0x18230 0x08>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 416eb94..549151e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -62,7 +62,7 @@
 			};
 
 			timer at 20300 {
-				marvell,timer-25Mhz;
+				compatible = "marvell,armada-xp-timer";
 			};
 
 			coreclk: mvebu-sar at 18230 {
-- 
1.8.1.5
