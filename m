From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 16 Feb 2017 22:18:58 +0100
Subject: [PATCH] ARM: imx25: set default phy_type and dr_mode for usbotg port
Message-ID: <20170216211858.8563-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All currently supported i.MX25-based machines use phy_type = "utmi" and
dr_mode = "otg".  So this seems to be a sensible default.

This also doesn't hurt out-of-tree machines because up to now they had
to specify these two properties in the machine.dts which still takes
precedence by just overwriting the defaults added here.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts | 2 --
 arch/arm/boot/dts/imx25-pdk.dts                        | 2 --
 arch/arm/boot/dts/imx25.dtsi                           | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 9300711f1ea3..db39bd6b8e00 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -179,8 +179,6 @@
 };
 
 &usbotg {
-	phy_type = "utmi";
-	dr_mode = "otg";
 	external-vbus-divider;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 70292101ba03..d921dd2ed676 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -309,8 +309,6 @@
 };
 
 &usbotg {
-	phy_type = "utmi";
-	dr_mode = "otg";
 	external-vbus-divider;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index d9ef338e8af7..6f1c7f82cdaa 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -535,6 +535,8 @@
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,usbphy = <&usbphy0>;
+				phy_type = "utmi";
+				dr_mode = "otg";
 				status = "disabled";
 			};
 
-- 
2.11.0
