From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 11 Jan 2014 15:00:51 +0100
Subject: [PATCH] arm: dtsi: am335x-bone-common, usb0 is peripheral only
Message-ID: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMIC is using usb0 vbus line as power source. It is also connected
to the am335x processor as vbus sense. But there is no possibility to
pullup usb0 vbus to operate as host. This patch fixes the dr_mode of usb0.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index e3f27ec..da2db9b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -197,6 +197,7 @@
 
 	usb at 47401000 {
 		status = "okay";
+		dr_mode = "peripheral";
 	};
 
 	usb at 47401800 {
-- 
1.8.5.2
