From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  5 Nov 2013 18:00:18 +0400
Subject: [PATCH] ARM: dts: i.MX51: Fix OTG PHY clock
Message-ID: <1383660018-32259-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proper clock ID for USB OTG PHY is "usb_phy_gate".
The patch changes this mismatch.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 48fa41b..06bb184 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -190,7 +190,7 @@
 
 			usbphy0: usbphy at 0 {
 				compatible = "usb-nop-xceiv";
-				clocks = <&clks 124>;
+				clocks = <&clks 75>;
 				clock-names = "main_clk";
 				status = "okay";
 			};
-- 
1.8.1.5
