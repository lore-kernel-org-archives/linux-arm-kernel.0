From: b20788@freescale.com (Anson Huang)
Date: Thu, 19 Dec 2013 13:17:23 -0500
Subject: [PATCH 1/3] ARM: dts: imx6qdl: add necessary thermal clk
Message-ID: <1387477045-19037-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thermal sensor needs pll3_usb_otg when measuring temperature,
so we need to pass clk info to thermal driver.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2e..72c7e2b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -550,6 +550,7 @@
 				interrupts = <0 49 0x04>;
 				fsl,tempmon = <&anatop>;
 				fsl,tempmon-data = <&ocotp>;
+				clocks = <&clks 172>;
 			};
 
 			usbphy1: usbphy at 020c9000 {
-- 
1.7.9.5
