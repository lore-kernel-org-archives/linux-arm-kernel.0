From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:03:00 +0800
Subject: [PATCH 06/11] ARM: dts: imx6q-sabrelite: add ssi device
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1335510185-7906-7-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    9 +++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   18 +++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 4e13293..7bd8855 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -22,6 +22,15 @@
 	};
 
 	soc {
+		aips-bus at 02000000 { /* AIPS1 */
+			spba-bus at 02000000 {
+				ssi1: ssi at 02028000 {
+					fsl,mode = "i2s-slave";
+					status = "okay";
+				};
+			};
+		};
+
 		aips-bus at 02100000 { /* AIPS2 */
 			enet at 02188000 {
 				phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fe8c80d..da42fc0 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -177,19 +177,31 @@
 					interrupts = <0 51 0x04>;
 				};
 
-				ssi at 02028000 { /* SSI1 */
+				ssi1: ssi at 02028000 {
+					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <38 37>;
+					status = "disabled";
 				};
 
-				ssi at 0202c000 { /* SSI2 */
+				ssi2: ssi at 0202c000 {
+					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <42 41>;
+					status = "disabled";
 				};
 
-				ssi at 02030000 { /* SSI3 */
+				ssi3: ssi at 02030000 {
+					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <46 45>;
+					status = "disabled";
 				};
 
 				asrc at 02034000 {
-- 
1.7.5.4
