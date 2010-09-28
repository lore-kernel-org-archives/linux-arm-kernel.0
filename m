From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 28 Sep 2010 22:13:46 +0200
Subject: [PATCH 2/5] ARM: imx/pcm038: make regulator platform data static
In-Reply-To: <20100928201230.GJ26352@pengutronix.de>
References: <20100928201230.GJ26352@pengutronix.de>
Message-ID: <1285704829-29406-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following sparse warning:

	arch/arm/mach-imx/pcm970-baseboard.c:203:30: warning: symbol 'pcm970_sja1000_platform_data' was not declared. Should it be static?

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-pcm038.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 641f9bb..a3d645f 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -257,7 +257,7 @@ static struct regulator_init_data cam_data = {
 	.consumer_supplies = cam_consumers,
 };
 
-struct mc13783_regulator_init_data pcm038_regulators[] = {
+static struct mc13783_regulator_init_data pcm038_regulators[] = {
 	{
 		.id = MC13783_REGU_VCAM,
 		.init_data = &cam_data,
-- 
1.7.2.3
