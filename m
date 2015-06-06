From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  6 Jun 2015 23:09:08 +0200
Subject: [PATCH 1/6] ARM: dts: pxa: add dma controller
Message-ID: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SoC embedded DMA controller, shared with the mmp architecture.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 9 +++++++++
 arch/arm/boot/dts/pxa3xx.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 90b9971..506db86 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -7,6 +7,15 @@
 	compatible = "marvell,pxa27x";
 
 	pxabus {
+		pdma: dma-controller at 40000000 {
+			compatible = "marvell,pdma-1.0";
+			reg = <0x40000000 0x10000>;
+			interrupts = <25>;
+			#dma-channels = <32>;
+			#dma-cells = <2>;
+			status = "okay";
+		};
+
 		pxairq: interrupt-controller at 40d00000 {
 			marvell,intc-priority;
 			marvell,intc-nr-irqs = <34>;
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 7ad0b17..4eb1563 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -6,6 +6,15 @@
 	compatible = "marvell,pxa3xx";
 
 	pxabus {
+		pdma: dma-controller at 40000000 {
+			compatible = "marvell,pdma-1.0";
+			reg = <0x40000000 0x10000>;
+			interrupts = <25>;
+			#dma-channels = <32>;
+			#dma-cells = <2>;
+			status = "okay";
+		};
+
 		pwri2c: i2c at 40f500c0 {
 			compatible = "mrvl,pwri2c";
 			reg = <0x40f500c0 0x30>;
-- 
2.1.4
