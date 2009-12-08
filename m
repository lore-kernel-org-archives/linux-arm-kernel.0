From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Dec 2009 22:14:08 +0100
Subject: [PATCH 3/5] spi-imx: use positive logic to distinguish cpu variants
In-Reply-To: <1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260306850-14945-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is much safer when support for new variants is added.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi_imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index d8d9a35..0ccbd1c 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -593,7 +593,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 	clk_enable(spi_imx->clk);
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk);
 
-	if (!cpu_is_mx31() || !cpu_is_mx35())
+	if (cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
 		writel(1, spi_imx->base + MXC_RESET);
 
 	/* drain receive buffer */
-- 
1.6.5.2
