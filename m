From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 28 Sep 2010 22:13:48 +0200
Subject: [PATCH 4/5] ARM: imx/pcm970: make platform_data static
In-Reply-To: <20100928201230.GJ26352@pengutronix.de>
References: <20100928201230.GJ26352@pengutronix.de>
Message-ID: <1285704829-29406-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following sparse warning:

	arch/arm/mach-imx/pcm970-baseboard.c:224:13: warning: symbol 'pcm970_baseboard_init' was not declared. Should it be static?

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/pcm970-baseboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 7cffad8..9110d9c 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -200,7 +200,7 @@ static struct resource pcm970_sja1000_resources[] = {
 	},
 };
 
-struct sja1000_platform_data pcm970_sja1000_platform_data = {
+static struct sja1000_platform_data pcm970_sja1000_platform_data = {
 	.osc_freq	= 16000000,
 	.ocr		= OCR_TX1_PULLDOWN | OCR_TX0_PUSHPULL,
 	.cdr		= CDR_CBP,
-- 
1.7.2.3
