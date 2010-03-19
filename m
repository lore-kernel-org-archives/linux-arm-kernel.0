From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Fri, 19 Mar 2010 18:16:59 +0300
Subject: [PATCH 3/3] imx31: add watchdog device on litekit board.
In-Reply-To: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <1269011819-23257-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for SoC build-in watchdog device on litekit
board.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index ccd8742..0201683 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -206,5 +206,6 @@ void __init mx31lite_db_init(void)
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
 	platform_device_register(&litekit_led_device);
+	mxc_register_device(&imx_wdt_device0, NULL);
 }
 
-- 
1.6.6.1
