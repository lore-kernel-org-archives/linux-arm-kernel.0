From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:18 +0100
Subject: [PATCH v3 14/15] at91: dt: at91sam9261ek: Enabled the USB host port
 (OHCI)
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-15-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 287b283..8bdbed9 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -32,6 +32,10 @@
 	};
 
 	ahb {
+		usb0: ohci at 00500000 {
+			status = "okay";
+		};
+
 		fb0: fb at 0x00600000 {
 			display = <&display0>;
 			atmel,power-control-gpio = <&pioA 12 GPIO_ACTIVE_LOW>;
-- 
1.8.5.2
