From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 23 May 2014 01:06:26 +0200
Subject: [PATCH 5/5] ARM: dts: OMAP3 a83x: fix duplicate usb pin config
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1400799986-20043-6-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node usbhshost is supporting pinctrl, so the deprecated
quirk call can be removed.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 2b3af90..d973088 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -176,9 +176,6 @@
 
 &omap3_pmx_core2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-			&hsusb1_2_pins
-	>;
 
 	hsusb1_2_pins: pinmux_hsusb1_2_pins {
 		pinctrl-single,pins = <
-- 
1.7.10.4
