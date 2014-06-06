From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri,  6 Jun 2014 13:02:59 +0200
Subject: [PATCH] ARM: dts: imx6: add missing compatible and clock properties
 for kpp
Message-ID: <1402052579-22803-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ce05991..3266d01 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -466,8 +466,10 @@
 			};
 
 			kpp: kpp at 020b8000 {
+				compatible = "fsl,imx6q-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks 62>; /* IPG clock */
 			};
 
 			wdog1: wdog at 020bc000 {
-- 
1.7.10.4
