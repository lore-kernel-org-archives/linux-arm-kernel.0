From: haikun.wang@freescale.com (Haikun Wang)
Date: Wed, 8 Jul 2015 10:43:40 +0800
Subject: [PATCH] arm: dts: ls1021a: Update 'dspi' device node compatible string
Message-ID: <1436323420-12846-1-git-send-email-haikun.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale DSPI driver has been updated and supports TCF interrupt type now.
In the new driver we choose the interrupt type according the compatible
string of the device node.
This patch update the compatible string of DSPI device node of LS1021A in
order to use the correct interrupt type.

Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..1b306c7 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -184,7 +184,7 @@
 		};
 
 		dspi0: dspi at 2100000 {
-			compatible = "fsl,vf610-dspi";
+			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
@@ -197,7 +197,7 @@
 		};
 
 		dspi1: dspi at 2110000 {
-			compatible = "fsl,vf610-dspi";
+			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2110000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
