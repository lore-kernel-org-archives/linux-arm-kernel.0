From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 19 Nov 2015 16:06:15 +0000
Subject: [PATCH RFC 3/4] ARM: bcm2835: specify card detect pin for RPi B
In-Reply-To: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1447949176-21926-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the Raspberry Pi B has a card detect pin. Specify it
on board level because it's not free to use.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index e6cd93b..1be2220 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -14,4 +14,9 @@
 
 &gpio {
 	pinctrl-0 = <&gpioout &alt0>;
+
+	sdhci_cd: sdhci_cd {
+		brcm,pins = <47>;
+		brcm,function = <BCM2835_FSEL_GPIO_IN>;
+	};
 };
-- 
1.7.9.5
