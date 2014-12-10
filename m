From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:32 +0100
Subject: [RFC 14/15] drm/panel/ld9040: do not power off panel on removal
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-15-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Panel is powered off already by connector during drm_panel_remove call.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/panel/panel-ld9040.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ld9040.c b/drivers/gpu/drm/panel/panel-ld9040.c
index 08cf2c5..3337f30 100644
--- a/drivers/gpu/drm/panel/panel-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-ld9040.c
@@ -361,7 +361,6 @@ static int ld9040_remove(struct spi_device *spi)
 {
 	struct ld9040 *ctx = spi_get_drvdata(spi);
 
-	ld9040_power_off(ctx);
 	drm_panel_remove(&ctx->panel);
 
 	return 0;
-- 
1.9.1
