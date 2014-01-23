From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:19 +0100
Subject: [PATCH v3 15/15] at91: dt: at91sam9261ek: Enabled the USB device port
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-16-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 8bdbed9..36cf677 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -106,6 +106,11 @@
 		};
 
 		apb {
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioB 29 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
-- 
1.8.5.2
