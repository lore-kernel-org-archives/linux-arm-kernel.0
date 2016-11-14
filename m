From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Nov 2016 15:44:09 +0000
Subject: [PATCH] ARM: dts: imx6q: replace gpio-key,
 wakeup with wakeup-source for Utilite Pro
Message-ID: <1479138250-17780-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any further copy-paste
duplication.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/imx6q-utilite-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

Inspite of getting rid of most of the legacy property almost a year ago,
addition of new platforms have brought this back and over time it's
now found again in few places. Just get rid of them *again*

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index 61990630a748..104bbe710927 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -68,7 +68,7 @@
 			label = "Power Button";
 			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
--
2.7.4
