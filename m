From: dongsheng.wang@freescale.com (Dongsheng Wang)
Date: Wed, 12 Aug 2015 12:01:00 +0800
Subject: [PATCH v3 1/2] Documentation: DT: FTM: add FTM0 be used as alarm timer
Message-ID: <1439352061-14656-1-git-send-email-dongsheng.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

In freescale layerscape platform there is only FTM0 can be used as
alarm timer to wake up system. So add FTM0 description for devicetree
document.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
V3:
Include this patch in V3.

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
index aa8c402..380a0b3d 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
@@ -1,5 +1,7 @@
 Freescale FlexTimer Module (FTM) Timer
 
+* Default FTM Timer
+
 Required properties:
 
 - compatible : should be "fsl,ftm-timer"
@@ -29,3 +31,26 @@ ftm: ftm at 400b8000 {
 		<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
 	big-endian;
 };
+
+* FTM Alarm Timer
+  The default FTM device contains eight FlexTimer modules. FlexTimer1 is in
+  on-domain(power is not switched off in deep sleep mode). Other seven FlexTimer
+  modules(flextimer2/3/4/5/6/7/8) are in off-domain (power is switched off in
+  deep sleep mode).
+
+Required properties:
+
+- compatible : should be "fsl,ftm-alarm".
+- reg : should contain base address and length of FTM timer 0 register.
+- interrupts : Should contain FTM 0 interrupt.
+- big-endian: One boolean property, the big endian mode will be in use if it is
+  present, or the little endian mode will be in use for all the device registers.
+
+Example:
+ftm0: ftm0 at 29d0000 {
+	compatible = "fsl,ftm-alarm";
+	reg = <0x0 0x29d0000 0x0 0x10000>;
+	interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+	big-endian;
+	status = "disabled";
+};
-- 
2.1.0.27.g96db324
