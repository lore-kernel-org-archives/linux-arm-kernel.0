From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 13:39:51 +0200
Subject: [RFC 3/3] ARM: dts: alpine: add msi-x controller
Message-ID: <55114d07.1KCcWZQxU8BGF1iI%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devicetree entry for the msi-x controller in alpine.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/boot/dts/alpine.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index 48589ca..f92c9dd 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -111,6 +111,17 @@
 			reg = <0x0 0xfb070000 0x0 0x10000>;
 		};
 
+		/* MSIX Configuration */
+		msix: msix at 0xfbe10000 {
+			compatible = "al,alpine-msix";
+			reg = <0x0 0xfbe10000 0x0 0x10000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>;
+			interrupt-controller;
+			msi-controller;
+			interrupt-parent = <&gic>;
+		};
+
 		/* Performance Monitor Unit */
 		pmu {
 			compatible = "arm,cortex-a15-pmu";
@@ -152,6 +163,8 @@
 					<0x4000 0 0 1 &gic 0 43 4>,
 					<0x4800 0 0 1 &gic 0 44 4>;
 
+			msi-parent = <&msix>;
+
 			/* 32 bit non prefetchable memory space */
 			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
 
-- 
1.9.1
