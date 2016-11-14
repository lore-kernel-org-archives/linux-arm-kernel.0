From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Nov 2016 15:44:07 +0000
Subject: [PATCH -next] ARM: dts: omap5: replace gpio-key,
 wakeup with wakeup-source property
Message-ID: <1479138250-17780-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any further copy-paste
duplication.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

Inspite of getting rid of most of the legacy property almost a year ago,
addition of new platforms have brought this back and over time it's
now found again in few places. Just get rid of them *again*

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 2fcdc516da45..a8c72611fbe3 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -41,7 +41,7 @@
 			label = "BTN1";
 			linux,code = <169>;
 			gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;	/* gpio3_83 */
-			gpio-key,wakeup;
+			wakeup-source;
 			autorepeat;
 			debounce_interval = <50>;
 		};
--
2.7.4
