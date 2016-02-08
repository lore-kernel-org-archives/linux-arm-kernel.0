From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  8 Feb 2016 21:55:53 +0000
Subject: [PATCH] ARM: dts: am335x/am57xx: replace gpio-key,
 wakeup with wakeup-source property
Message-ID: <1454968553-12088-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3efda00129bd ("ARM: dts: am335x: replace gpio-key,wakeup with
wakeup-source property") replaces all the legacy "gpio-key,wakeup" with
the unified  "wakeup-source" property to prevent any further copy-paste
duplication.

However couple of use of these legacy property sneaked in during the
merge window. This patch replaces them too.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/am335x-shc.dts          | 4 ++--
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Hi Tony,

I see these files got introduced during v4.5 merge window and we could
not stop the copy-paste from the earlier versions files from which they
were copied.

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 1b5b044fcd91..865de8500f1c 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -46,7 +46,7 @@
 			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_BACK>;
 			debounce-interval = <1000>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		front_button {
@@ -54,7 +54,7 @@
 			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_FRONT>;
 			debounce-interval = <1000>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index c53882643ae9..497eb07ced19 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -545,7 +545,7 @@
 		ti,debounce-tol = /bits/ 16 <10>;
 		ti,debounce-rep = /bits/ 16 <1>;
 
-		linux,wakeup;
+		wakeup-source;
 	};
 };
 
-- 
1.9.1
