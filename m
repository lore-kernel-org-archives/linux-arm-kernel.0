From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 26 Feb 2014 09:50:46 -0300
Subject: [PATCH 1/2] ARM: mvebu: Enable Armada 375 watchdog in the devicetree
In-Reply-To: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1393419047-10071-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes to enable the watchdog support available on
Armada 375 SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 3877693f..a2003cb 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -320,6 +320,12 @@
 				clocks = <&coreclk 0>;
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,armada-375-wdt", "marvell,armada-370-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>;
+				clocks = <&coreclk 0>;
+			};
+
 			xor at 60800 {
 				compatible = "marvell,orion-xor";
 				reg = <0x60800 0x100
-- 
1.8.1.5
