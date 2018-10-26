From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 26 Oct 2018 20:41:58 +0200
Subject: [PATCH 4/4] bus: ts-nbus: weaken driver dependency to allow broader
 compile testing
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20181026184157.16371-4-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is nothing specific for the i.MX28 SoC in the ts-nbus driver and
it compiles just fine with an ARM/s3c24xx configuration.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..bf1f43b847e9 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -149,7 +149,7 @@ config TI_SYSC
 
 config TS_NBUS
 	tristate "Technologic Systems NBUS Driver"
-	depends on SOC_IMX28
+	depends on SOC_IMX28 || COMPILE_TEST
 	depends on OF_GPIO && PWM
 	help
 	  Driver for the Technologic Systems NBUS which is used to interface
-- 
2.19.1
