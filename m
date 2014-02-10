From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 20:00:34 -0300
Subject: [PATCH v7 15/18] ARM: dove: Enable Dove watchdog in the devicetree
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392073237-2554-16-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree node to enable watchdog support available in Dove SoCs.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/dove.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 2b76524..a88ed73 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -210,6 +210,14 @@
 				clocks = <&core_clk 0>;
 			};
 
+			watchdog at 20300 {
+				compatible = "marvell,orion-wdt";
+				reg = <0x20300 0x28>, <0x20108 0x4>;
+				interrupt-parent = <&bridge_intc>;
+				interrupts = <3>;
+				clocks = <&core_clk 0>;
+			};
+
 			crypto: crypto-engine at 30000 {
 				compatible = "marvell,orion-crypto";
 				reg = <0x30000 0x10000>,
-- 
1.8.1.5
