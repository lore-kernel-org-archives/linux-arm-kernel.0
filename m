From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 2 Aug 2016 17:08:23 +0800
Subject: [PATCH 1/1] ARM: dts: imx6ul-14x14-evk: add USB dual-role support
Message-ID: <1470128903-942-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 851ce932242d ("usb: chipidea: otg: don't wait vbus
drops below BSV when starts host"), the driver can support
enabling vbus output without software control, so this board
(control vbus output through ID pin) can support dual-role now.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index e281d50..c5cf942 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -225,7 +225,7 @@
 };
 
 &usbotg1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
1.9.1
