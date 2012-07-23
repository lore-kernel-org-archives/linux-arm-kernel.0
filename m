From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:29 +0200
Subject: [PATCH 24/25] macintosh/mediabay: make data used as
 *of_device_id.data const
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-25-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

[ukl: split Arnd's patch by driver]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/macintosh/mediabay.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 54bf584..3f8d032 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -669,7 +669,7 @@ static int media_bay_resume(struct macio_dev *mdev)
 
 /* Definitions of "ops" structures.
  */
-static struct mb_ops ohare_mb_ops = {
+static const struct mb_ops ohare_mb_ops = {
 	.name		= "Ohare",
 	.content	= ohare_mb_content,
 	.power		= ohare_mb_power,
@@ -678,7 +678,7 @@ static struct mb_ops ohare_mb_ops = {
 	.un_reset_ide	= ohare_mb_un_reset_ide,
 };
 
-static struct mb_ops heathrow_mb_ops = {
+static const struct mb_ops heathrow_mb_ops = {
 	.name		= "Heathrow",
 	.content	= heathrow_mb_content,
 	.power		= heathrow_mb_power,
@@ -687,7 +687,7 @@ static struct mb_ops heathrow_mb_ops = {
 	.un_reset_ide	= heathrow_mb_un_reset_ide,
 };
 
-static struct mb_ops keylargo_mb_ops = {
+static const struct mb_ops keylargo_mb_ops = {
 	.name		= "KeyLargo",
 	.init		= keylargo_mb_init,
 	.content	= keylargo_mb_content,
-- 
1.7.10.4
