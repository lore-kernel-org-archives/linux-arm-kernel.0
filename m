From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:15 +0100
Subject: [PATCH 18/19] ARM: dts: ste: replace legacy *,
 wakeup property with wakeup-source
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-19-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "linux,wakeup" boolean property to enable the wakeup
source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 2 +-
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 0e1c96943d47..3228119f91d1 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -66,7 +66,7 @@
 					keypad,num-columns = <8>;
 					keypad,num-rows = <8>;
 					linux,no-autorepeat;
-					linux,wakeup;
+					wakeup-source;
 					linux,keymap = <0x0301006b
 						        0x04010066
 							0x06040072
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 35282c0105c6..789329030658 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -163,7 +163,7 @@
 			label = "user_button";
 			gpios = <&gpio0 3 0x1>;
 			linux,code = <1>; /* KEY_ESC */
-			gpio-key,wakeup;
+			wakeup-source;
 			pinctrl-names = "default";
 			pinctrl-0 = <&user_button_default_mode>;
 		};
-- 
1.9.1
