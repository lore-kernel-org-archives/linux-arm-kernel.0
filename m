From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Aug 2011 15:28:23 +0200
Subject: [PATCH 4/6] ARM: imx: use mc13xxx constants instead of mc13783
In-Reply-To: <1314192505-23499-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110824132740.GA28197@pengutronix.de>
	<1314192505-23499-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1314192505-23499-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latter constants are going to be removed in favour of the former

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |    4 ++--
 arch/arm/mach-imx/mach-mx31_3ds.c |    2 +-
 arch/arm/mach-imx/mach-pcm038.c   |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6fa6934..3856855 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -293,8 +293,8 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
 
 	},
-	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN |
-	MC13783_USE_RTC,
+	.flags  = MC13XXX_USE_REGULATOR | MC13XXX_USE_TOUCHSCREEN |
+		MC13XXX_USE_RTC,
 };
 
 /* SPI */
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index c20be75..aa2ebe6 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -494,7 +494,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.regulators = mx31_3ds_regulators,
 		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
 	},
-	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
+	.flags  = MC13XXX_USE_REGULATOR | MC13XXX_USE_TOUCHSCREEN,
 };
 
 /* SPI */
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 2d6a64b..d033774 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -266,8 +266,8 @@ static struct mc13xxx_platform_data pcm038_pmic = {
 		.regulators = pcm038_regulators,
 		.num_regulators = ARRAY_SIZE(pcm038_regulators),
 	},
-	.flags = MC13783_USE_ADC | MC13783_USE_REGULATOR |
-		 MC13783_USE_TOUCHSCREEN,
+	.flags = MC13XXX_USE_ADC | MC13XXX_USE_REGULATOR |
+		 MC13XXX_USE_TOUCHSCREEN,
 };
 
 static struct spi_board_info pcm038_spi_board_info[] __initdata = {
-- 
1.7.5.4
