From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:40 +0200
Subject: [PATCH 05/17] ARM: dts: lpc18xx: add ssp nodes
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-6-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the ARM SSP controllers on lpc18xx.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 60dc929568b3..920cdb26743c 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -123,6 +123,17 @@
 			status = "disabled";
 		};
 
+		ssp0: spi at 40083000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x40083000 0x1000>;
+			interrupts = <22>;
+			clocks = <&ccu2 CLK_APB0_SSP0>, <&ccu1 CLK_CPU_SSP0>;
+			clock-names = "sspclk", "apb_pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		timer0: timer at 40084000 {
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x40084000 0x1000>;
@@ -181,6 +192,17 @@
 			clock-names = "timerclk";
 		};
 
+		ssp1: spi at 400c5000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x400c5000 0x1000>;
+			interrupts = <23>;
+			clocks = <&ccu2 CLK_APB2_SSP1>, <&ccu1 CLK_CPU_SSP1>;
+			clock-names = "sspclk", "apb_pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gpio: gpio at 400f4000 {
 			compatible = "nxp,lpc1850-gpio";
 			reg = <0x400f4000 0x4000>;
-- 
1.8.0
