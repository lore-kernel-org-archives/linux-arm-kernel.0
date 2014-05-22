From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 22 May 2014 15:06:04 +0200
Subject: [PATCH v2] ARM: socfpga: dts: add watchdog0+1
Message-ID: <1400763964-19369-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoCFPGA has two watchdog timers. Add them to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 56fc214..7bcd458 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -549,6 +549,22 @@
 			reg = <0xffd05000 0x1000>;
 		};
 
+		watchdog0: watchdog at ffd02000 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd02000 0x1000>;
+			interrupts = <0 171 0>;
+			clocks = <&osc1>;
+			status = "disabled";
+		};
+
+		watchdog1: watchdog at ffd03000 {
+			compatible = "snps,dw-wdt";
+			reg = <0xffd03000 0x1000>;
+			interrupts = <0 172 0>;
+			clocks = <&osc1>;
+			status = "disabled";
+		};
+
 		sysmgr: sysmgr at ffd08000 {
 			compatible = "altr,sys-mgr", "syscon";
 			reg = <0xffd08000 0x4000>;
-- 
2.0.0.rc0
