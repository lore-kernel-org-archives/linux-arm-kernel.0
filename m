From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 26 May 2013 17:33:38 +0200
Subject: [PATCH 2/5] ARM: at91: dt: usb-a9263: update shutdown controller
In-Reply-To: <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130526153037.GQ24476@game.jcrosoft.org>
 <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1369582421-25562-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable rtt and wakeup button (5 msec low)

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: gregory hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/usb_a9263.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index f8ec36c..e7eb9ae 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -47,6 +47,10 @@
 				status = "okay";
 			};
 
+			shdwc at fffffd10 {
+				atmel,wakeup-counter = <10>;
+				atmel,wakeup-rtt-timer;
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.10.4
