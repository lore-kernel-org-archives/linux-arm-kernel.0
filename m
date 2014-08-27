From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 27 Aug 2014 17:52:49 +0800
Subject: [PATCH] dtb: at91: sam9n12ek: ohci: add port and vbus property
Message-ID: <1409133169-26741-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the port number and vbus property for ohci port, or else if
bootloader won't configure the vbus pin, the 5v supply is not
power on, so can not work with usb devices.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/at91sam9n12ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 83d7237..13bb24e 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -136,6 +136,8 @@
 		};
 
 		usb0: ohci at 00500000 {
+			num-ports = <1>;
+			atmel,vbus-gpio = <&pioB 7 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
-- 
1.8.5.2
