From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 26 May 2013 17:33:39 +0200
Subject: [PATCH 3/5] ARM: at91: dt: usb-a9263: add dataflash support
In-Reply-To: <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130526153037.GQ24476@game.jcrosoft.org>
 <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1369582421-25562-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: gregory hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/usb_a9263.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index e7eb9ae..290e603 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -47,6 +47,16 @@
 				status = "okay";
 			};
 
+			spi0: spi at fffa4000 {
+				cs-gpios = <&pioB 15 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					reg = <0>;
+					spi-max-frequency = <15000000>;
+				};
+			};
+
 			shdwc at fffffd10 {
 				atmel,wakeup-counter = <10>;
 				atmel,wakeup-rtt-timer;
-- 
1.7.10.4
