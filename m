From: henryzhang62@gmail.com (henryzhang62 at gmail.com)
Date: Wed, 17 Jan 2018 18:41:33 -0800
Subject: [PATCH v4] ARM: dts: bcm283x: Fix pin function of JTAG pins
Message-ID: <1516243293-25010-1-git-send-email-henryzhang62@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Henry Zhang <henryzhang62@gmail.com>

BCM2835 ARM Peripherals doc shows gpio pins 4, 5, 6, 12 and 13
carry altenate function, ALT5 for ARM JTAG

Fixes: 21ff843931b2 ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")

Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index dcde93c..64971e4 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -251,7 +251,7 @@
 
 			jtag_gpio4: jtag_gpio4 {
 				brcm,pins = <4 5 6 12 13>;
-				brcm,function = <BCM2835_FSEL_ALT4>;
+				brcm,function = <BCM2835_FSEL_ALT5>;
 			};
 			jtag_gpio22: jtag_gpio22 {
 				brcm,pins = <22 23 24 25 26 27>;
-- 
2.7.4
