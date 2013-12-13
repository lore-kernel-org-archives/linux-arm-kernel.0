From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:14 -0700
Subject: [PATCH V1 10/11] ARM: dts: imx6qdl-sabrelite: Add over-current pin to
 usbotg
In-Reply-To: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1386899355-17379-11-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KEY_COL4 is over-current for usbotg on Sabre Lite.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 24e4c81..1a95faf 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -260,7 +260,10 @@
 		};
 
 		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <MX6QDL_USBOTG_PINGRP1>;
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x17059
+				MX6QDL_PAD_KEY_COL4__USB_OTG_OC	0x1b0b0
+			>;
 		};
 
 		pinctrl_usdhc3: usdhc3grp {
-- 
1.8.1.2
