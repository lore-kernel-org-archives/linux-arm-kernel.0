From: stefan@agner.ch (Stefan Agner)
Date: Fri, 28 Nov 2014 00:35:36 +0100
Subject: [PATCH] ARM: dts: vf610: enable watchdog for Cortex-A5 dt's
Message-ID: <1417131336-3136-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During restructuring of the device tree files the watchdog was
changed to be disabled by default. However, since the watchdog
instance is dedicated to the Cortex-A5, enable the peripheral
by default in the base device tree vf500.dtsi.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi | 5 +++++
 arch/arm/boot/dts/vfxxx.dtsi | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index de67005..ea0f74f 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -169,3 +169,8 @@
 &usbphy1 {
 	interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&wdoga5 {
+	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 505969a..7126468 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -184,7 +184,7 @@
 				status = "disabled";
 			};
 
-			wdog at 4003e000 {
+			wdoga5: wdog at 4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
 				clocks = <&clks VF610_CLK_WDT>;
-- 
2.1.3
