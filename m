From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:18 +0200
Subject: [PATCH 13/25] macintosh/mediabay: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/macintosh/mediabay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 831d751..54bf584 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -63,7 +63,7 @@ struct media_bay_info {
 	int				value_count;
 	int				timer;
 	struct macio_dev		*mdev;
-	struct mb_ops*			ops;
+	const struct mb_ops*		ops;
 	int				index;
 	int				cached_gpio;
 	int				sleeping;
-- 
1.7.10.4
