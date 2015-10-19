From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 16:49:45 +0800
Subject: [PATCH 4/8] arm64: dts: berlin4ct: add watchdog nodes
In-Reply-To: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
References: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445244589-4838-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Berlin BG4CT has 3 watchdogs which are compatible with the
snps,dw-wdt driver sit in the sysmgr domain. This patch adds the
corresponding device tree nodes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index a3b5f1d..8eddf10 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -241,6 +241,30 @@
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			wdt0: watchdog at 3000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x3000 0x100>;
+				clocks = <&osc>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
+			wdt1: watchdog at 4000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x4000 0x100>;
+				clocks = <&osc>;
+				interrupts = <1>;
+				status = "disabled";
+			};
+
+			wdt2: watchdog at 5000 {
+				compatible = "snps,dw-wdt";
+				reg = <0x5000 0x100>;
+				clocks = <&osc>;
+				interrupts = <2>;
+				status = "disabled";
+			};
+
 			sm_gpio0: gpio at 8000 {
 				compatible = "snps,dw-apb-gpio";
 				reg = <0x8000 0x400>;
-- 
2.6.1
