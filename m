From: b18965@freescale.com (Alison Wang)
Date: Mon, 14 Sep 2015 14:45:28 +0800
Subject: [PATCH] ARM: ls1021a: Add dma-coherent property for eTSEC nodes
Message-ID: <1442213128-39279-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dma-coherent property for eTSEC nodes, so
coherent DMA operations are supported.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/ls1021a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 973a496..e1a16ed 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -405,6 +405,7 @@
 			model = "eTSEC";
 			fsl,magic-packet;
 			ranges;
+			dma-coherent;
 
 			queue-group at 2d10000 {
 				#address-cells = <2>;
@@ -433,6 +434,7 @@
 			interrupt-parent = <&gic>;
 			model = "eTSEC";
 			ranges;
+			dma-coherent;
 
 			queue-group at 2d50000  {
 				#address-cells = <2>;
@@ -461,6 +463,7 @@
 			interrupt-parent = <&gic>;
 			model = "eTSEC";
 			ranges;
+			dma-coherent;
 
 			queue-group at 2d90000  {
 				#address-cells = <2>;
-- 
2.1.0.27.g96db324
