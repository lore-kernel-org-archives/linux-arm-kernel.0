From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 15 Mar 2014 15:18:03 -0300
Subject: [PATCH v4 8/9] ARM: mvebu: Enable Armada 380/385 watchdog in the
 devicetree
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394907484-26002-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes to enable the watchdog support available on
Armada 380/385 SoC.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a064f59..9a94196 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -267,6 +267,13 @@
 				clock-names = "nbclk", "fixed";
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,armada-380-wdt";
+				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
 			eth1: ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x30000 0x4000>;
-- 
1.9.0
