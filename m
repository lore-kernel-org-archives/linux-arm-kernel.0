From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Nov 2016 15:44:08 +0000
Subject: [PATCH] ARM: dts: at91: replace gpio-key,
 wakeup with wakeup-source for sam9260ek
Message-ID: <1479138250-17780-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any further copy-paste
duplication.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/at91sam9260ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Hi,

Inspite of getting rid of most of the legacy property almost a year ago,
addition of new platforms have brought this back and over time it's
now found again in few places. Just get rid of them *again*

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index 2c87f58448e7..b2578feceb08 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -174,14 +174,14 @@
 			label = "Button 3";
 			gpios = <&pioA 30 GPIO_ACTIVE_LOW>;
 			linux,code = <0x103>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};

 		btn4 {
 			label = "Button 4";
 			gpios = <&pioA 31 GPIO_ACTIVE_LOW>;
 			linux,code = <0x104>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};

--
2.7.4
