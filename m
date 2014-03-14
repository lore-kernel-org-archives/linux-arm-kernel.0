From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 14 Mar 2014 16:53:37 +0100
Subject: [PATCH 2/2] ARM: efm32: properly namespace i2c location property
In-Reply-To: <1394812417-22391-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1394812417-22391-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1394812417-22391-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang pointed out during review of an efm32-i2c driver that the
property to specify the set of pins has a too general name. As several
other efm32 peripherals also have a similar register bit field, add an
"efm32" namespace.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/efm32gg-dk3750.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index aa5c0f6363d6..b4031fa4a567 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -26,7 +26,7 @@
 		};
 
 		i2c at 4000a000 {
-			location = <3>;
+			efm32,location = <3>;
 			status = "ok";
 
 			temp at 48 {
-- 
1.9.0
