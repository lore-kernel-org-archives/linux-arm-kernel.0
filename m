From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:05:05 +0200
Subject: [PATCH 05/11] arm: dts: lpc32xx: add clock controller device node
In-Reply-To: <1447981511-29653-1-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
Message-ID: <1447981511-29653-6-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx SoC has a clocking and power control unit (CPC) as a part
of system control block (SCB). CPC is supplied by two external
oscillators and it manages core and most of peripheral clocks, the
change adds SCB and CPC descriptions to shared LPC32xx dtsi file.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index a9f2d9a..65023c1 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -247,6 +247,23 @@
 			compatible = "simple-bus";
 			ranges = <0x20000000 0x20000000 0x30000000>;
 
+			/* System Control Block */
+			scb {
+				compatible = "simple-bus";
+				ranges = <0x0 0x040004000 0x00001000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				clk: clock-controller at 0 {
+					compatible = "nxp,lpc3220-clk";
+					reg = <0x00 0x114>;
+					#clock-cells = <1>;
+
+					clocks = <&xtal_32k>, <&xtal>;
+					clock-names = "xtal_32k", "xtal";
+				};
+			};
+
 			/*
 			 * MIC Interrupt controller includes:
 			 *   MIC @40008000
-- 
2.1.4
