From: t.remmet@phytec.de (Teresa Remmet)
Date: Fri, 10 Feb 2017 13:29:07 +0100
Subject: [PATCH] ARM: dts: am335x-pcm953: Fix legacy wakeup source binding
Message-ID: <1486729747-4604-1-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replaced the legacy binding "gpio-key,wakeup" with "wakeup-source" as
noted in the kernel documentation.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/am335x-pcm-953.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 02981ea..1ec8e0d 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -63,14 +63,14 @@
 			label = "home";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		button at 1 {
 			label = "menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 	};
-- 
1.9.1
