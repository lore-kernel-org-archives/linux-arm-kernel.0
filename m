From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:13:02 -0700
Subject: [PATCH V2 12/13] ARM: dts: imx6qdl-sabrelite: Add over-current pin to
 usbotg
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-13-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KEY_COL4 is over-current for usbotg on Sabre Lite.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Reviewed-by: Marek Vasut <marex@denx.de>

---
v2: no change
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index f1d8b24..b2711ae 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -268,7 +268,8 @@
 
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
-				MX6QDL_USBOTG_PINGRP1
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x17059
+				MX6QDL_PAD_KEY_COL4__USB_OTG_OC	0x1b0b0
 				/* power enable, high active */
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x000b0
 			>;
-- 
1.8.1.2
