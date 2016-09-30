From: iw3gtf@arcor.de (Giorgio Dal Molin)
Date: Fri, 30 Sep 2016 15:13:05 +0200
Subject: [PATCH] arm: dts: imx6dl: force the 'compatible' field for the
 uart[12345] to 'fsl, imx21-uart'.
Message-ID: <20160930131305.9584-1-iw3gtf@arcor.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this fix the imx uart kernel driver selects 'fsl,imx6q-uart' as
its compatible value and the port does not work properly.

The kind of malfunctioning I noticed was while receiving bytes from the
uart, sending out was OK.

Signed-off-by: Giorgio Dal Molin <iw3gtf@arcor.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 9a4c22c..1a1d5fd 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -131,3 +131,23 @@
 &vpu {
 	compatible = "fsl,imx6dl-vpu", "cnm,coda960";
 };
+
+&uart1 {
+	compatible = "fsl,imx21-uart";
+};
+
+&uart2 {
+	compatible = "fsl,imx21-uart";
+};
+
+&uart3 {
+	compatible = "fsl,imx21-uart";
+};
+
+&uart4 {
+	compatible = "fsl,imx21-uart";
+};
+
+&uart5 {
+	compatible = "fsl,imx21-uart";
+};
-- 
2.10.0
