From: marex@denx.de (Marek Vasut)
Date: Wed,  9 Jul 2014 13:56:01 +0200
Subject: [PATCH] ARM: dts: mx5: Move the USB pinmux to USB node on M53EVK
In-Reply-To: <20140628151551.GE7869@dragon>
References: <20140628151551.GE7869@dragon>
Message-ID: <1404906961-11920-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB pinmux should be in the USB Host1 node, not in the Hog node
of the pinmux controller.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 1883d0d..d0e0f57 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -158,7 +158,7 @@
 
 &iomuxc {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog &pinctrl_usb>;
+	pinctrl-0 = <&pinctrl_hog>;
 
 	imx53-m53evk {
 		pinctrl_usb: usbgrp {
@@ -343,6 +343,8 @@
 };
 
 &usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb>;
 	vbus-supply = <&reg_usbh1_vbus>;
 	phy_type = "utmi";
 	status = "okay";
-- 
2.0.0
