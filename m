From: b18965@freescale.com (Alison Wang)
Date: Mon, 6 Jul 2015 10:38:39 +0800
Subject: [PATCH] arm: dts: ls1021a: add wakeup device ftm0 node for ls1021a
Message-ID: <1436150319-15122-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Add ftm0 node, cause of ftm0 can be set as a alarm before system
going to deep sleep.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 4 ++++
 arch/arm/boot/dts/ls1021a.dtsi    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9533f1d..e2ccae6 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -146,6 +146,10 @@
 	status = "okay";
 };
 
+&ftm0 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 4ad30d0..707850f 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -335,6 +335,14 @@
 			status = "disabled";
 		};
 
+		ftm0: ftm0 at 29d0000 {
+			compatible = "fsl,ftm-alarm";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+			status = "disabled";
+		};
+
 		wdog0: watchdog at 2ad0000 {
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
