From: b18965@freescale.com (Alison Wang)
Date: Wed, 15 Jul 2015 15:40:11 +0800
Subject: [PATCH v2] ARM: dts: ls1021a: add wakeup device ftm0 node for ls1021a
Message-ID: <1436946011-30113-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ftm0 node, cause of ftm0 can be set as a alarm before system
going to deep sleep.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
Changes since v1:
- Add my SoB.
- Use "ARM:" as subject prefix.

 arch/arm/boot/dts/ls1021a-qds.dts | 4 ++++
 arch/arm/boot/dts/ls1021a.dtsi    | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9c5e16b..f14731b 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -75,6 +75,10 @@
 	};
 };
 
+&ftm0 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..7e9e122 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -332,6 +332,14 @@
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
