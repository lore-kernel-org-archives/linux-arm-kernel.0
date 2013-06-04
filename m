From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Jun 2013 15:17:06 +0800
Subject: [PATCH] ARM: dts: imx: add tempmon node for imx6q thermal support
In-Reply-To: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
References: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1370330226-6030-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark ocotp as a syscon node and add tempmon for imx6q thermal support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9e8296e..13e1d7f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -489,6 +489,13 @@
 				};
 			};
 
+			tempmon: tempmon {
+				compatible = "fsl,imx6q-tempmon";
+				interrupts = <0 49 0x04>;
+				fsl,tempmon = <&anatop>;
+				fsl,tempmon-data = <&ocotp>;
+			};
+
 			usbphy1: usbphy at 020c9000 {
 				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
@@ -747,8 +754,8 @@
 				interrupts = <0 14 0x04>;
 			};
 
-			ocotp at 021bc000 {
-				compatible = "fsl,imx6q-ocotp";
+			ocotp: ocotp at 021bc000 {
+				compatible = "fsl,imx6q-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 			};
 
-- 
1.7.9.5
