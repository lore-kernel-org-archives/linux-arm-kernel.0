From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 16:49:44 +0800
Subject: [PATCH 3/8] arm: dts: berlin2: add watchdog nodes
In-Reply-To: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
References: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445244589-4838-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Berlin BG2 has 3 watchdogs which are compatible with the
snps,dw-wdt driver sit in the sysmgr domain. This patch adds the
corresponding device tree nodes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index ef811de..7e35de2 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -412,6 +412,30 @@
 			ranges = <0 0xfc0000 0x10000>;
 			interrupt-parent = <&sic>;
 
+			wdt0: watchdog at 1000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x1000 0x100>;
+				clocks = <&refclk>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
+			wdt1: watchdog at 2000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x2000 0x100>;
+				clocks = <&refclk>;
+				interrupts = <1>;
+				status = "disabled";
+			};
+
+			wdt2: watchdog at 3000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x3000 0x100>;
+				clocks = <&refclk>;
+				interrupts = <2>;
+				status = "disabled";
+			};
+
 			sm_gpio1: gpio at 5000 {
 				compatible = "snps,dw-apb-gpio";
 				reg = <0x5000 0x400>;
-- 
2.6.1
