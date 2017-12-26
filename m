From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Dec 2017 16:04:20 -0200
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Add missing #phy-cells to
 usb-nop-xceiv
Message-ID: <1514311460-8840-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 915fbe59cbf2fe6 ("ARM: dts: imx: Add missing #phy-cells to
usb-nop-xceiv") missed to update imx51-zii-rdu1.dts probably due to a
merge timing issue, so add #phy-cells here too. 

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 70fdcdd..5306b78 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -271,6 +271,7 @@
 		clock-names = "main_clk";
 		reset-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&vusb_reg>;
+		#phy-cells = <0>;
 	};
 
 	usbh2phy: usbphy2 {
@@ -281,6 +282,7 @@
 		clock-names = "main_clk";
 		reset-gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&vusb_reg>;
+		#phy-cells = <0>;
 	};
 };
 
-- 
2.7.4
