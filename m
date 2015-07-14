From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:41 +0200
Subject: [PATCH 06/17] ARM: dts: lpc18xx: add can nodes
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 920cdb26743c..813ed93d6570 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -156,6 +156,14 @@
 			clocks = <&ccu1 CLK_CPU_SCU>;
 		};
 
+		can1: can at 400a4000 {
+			compatible = "bosch,c_can";
+			reg = <0x400a4000 0x1000>;
+			interrupts = <43>;
+			clocks = <&ccu1 CLK_APB1_CAN1>;
+			status = "disabled";
+		};
+
 		uart2: serial at 400c1000 {
 			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x400c1000 0x1000>;
@@ -203,6 +211,14 @@
 			status = "disabled";
 		};
 
+		can0: can at 400e2000 {
+			compatible = "bosch,c_can";
+			reg = <0x400e2000 0x1000>;
+			interrupts = <51>;
+			clocks = <&ccu1 CLK_APB3_CAN0>;
+			status = "disabled";
+		};
+
 		gpio: gpio at 400f4000 {
 			compatible = "nxp,lpc1850-gpio";
 			reg = <0x400f4000 0x4000>;
-- 
1.8.0
