From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  2 Jun 2015 17:41:33 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: Add HDMI support
Message-ID: <1433277693-10767-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add HDMI support. As the DDC I2C pins are not connected due to
pin conflicts, we do not pass the 'ddc-i2c-bus' property in 
this case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 46b2fed..48ccfee 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -76,6 +76,10 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
1.9.1
