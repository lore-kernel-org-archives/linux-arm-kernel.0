From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 15:03:01 +0000
Subject: [PATCH v2 13/16] ARM: dts: imx6qdl: SolidRun: fix node names
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <E1eJhPZ-0006OR-He@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node names are supposed to be generic, fix the RTC and codec node
names for both Hummingboard and Cubox-i.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 7a3fba776661..ca04ec56d2af 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -135,7 +135,7 @@
 
 	status = "okay";
 
-	rtc: pcf8523 at 68 {
+	rtc at 68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 66bda5a04582..92583238ca4a 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -150,13 +150,13 @@
 	status = "okay";
 
 	/* Pro baseboard model */
-	rtc: pcf8523 at 68 {
+	rtc at 68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
 
 	/* Pro baseboard model */
-	sgtl5000: sgtl5000 at a {
+	sgtl5000: codec at a {
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
-- 
2.7.4
