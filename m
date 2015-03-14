From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 14 Mar 2015 11:57:17 +0800
Subject: [PATCH v5 2/2] ARM: dts: sun9i: optimus: Switch to phy core regulator
 bindings for usb phys
In-Reply-To: <1426305437-15208-1-git-send-email-wens@csie.org>
References: <1426305437-15208-1-git-send-email-wens@csie.org>
Message-ID: <1426305437-15208-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the phy core already supports specifying a regulator to handle
during power up/down, it was decided to drop the regulator support
in the sun9i usb phy driver.

This patch switches the DT to the core bindings. This and the phy driver
would be in the same release and should not be a problem as far as DT
stability goes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index e53f2656c2d0..c6ca116c59d2 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -203,7 +203,7 @@
 };
 
 &usbphy1 {
-	vbus-supply = <&reg_usb1_vbus>;
+	phy-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
 
@@ -212,6 +212,6 @@
 };
 
 &usbphy3 {
-	vbus-supply = <&reg_usb3_vbus>;
+	phy-supply = <&reg_usb3_vbus>;
 	status = "okay";
 };
-- 
2.1.4
