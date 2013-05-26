From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 26 May 2013 17:33:37 +0200
Subject: [PATCH 1/5] ARM: at91: dt: usb-a9260: update shutdown controller
In-Reply-To: <20130526153037.GQ24476@game.jcrosoft.org>
References: <20130526153037.GQ24476@game.jcrosoft.org>
Message-ID: <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable rtt and wakeup button (5 msec low)

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: gregory hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/usb_a9260.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/usb_a9260.dts
index a604107..de0c24f 100644
--- a/arch/arm/boot/dts/usb_a9260.dts
+++ b/arch/arm/boot/dts/usb_a9260.dts
@@ -20,4 +20,13 @@
 	memory {
 		reg = <0x20000000 0x4000000>;
 	};
+
+	ahb {
+		apb {
+			shdwc at fffffd10 {
+				atmel,wakeup-counter = <10>;
+				atmel,wakeup-rtt-timer;
+			};
+		};
+	};
 };
-- 
1.7.10.4
