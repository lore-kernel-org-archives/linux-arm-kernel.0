From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 13 Aug 2013 11:43:15 -0300
Subject: [PATCH v4 6/6] ARM: mvebu: Fix the Armada 370/XP timer compatible
 strings
In-Reply-To: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1376404995-24548-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "marvell,armada-370-xp-timer" compatible string, together with
the "marvell,timer-25Mhz" property are deprecated and should be
removed from current DT.

Instead, the timer DT nodes are now required to have an appropriate
compatible string, which should be either "marvell,armada-370-timer"
or "marvell,armada-xp-timer", depending on SoC.

The clock property is now required only for Armada 370 so move it accordingly.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 --
 arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..442c84e 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -81,10 +81,8 @@
 			};
 
 			timer at 20300 {
-				compatible = "marvell,armada-370-xp-timer";
 				reg = <0x20300 0x30>, <0x21040 0x30>;
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
-				clocks = <&coreclk 2>;
 			};
 
 			sata at a0000 {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..f166367 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -104,6 +104,11 @@
 				interrupts = <91>;
 			};
 
+			timer at 20300 {
+				compatible = "marvell,armada-370-timer";
+				clocks = <&coreclk 2>;
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
