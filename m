From: yhvh2000@gmail.com (William Stevenson)
Date: Thu,  9 Feb 2017 21:57:49 +0000
Subject: [PATCH] Do not initialise statics to NULL
Message-ID: <20170209215749.2664-1-yhvh2000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a checkpatch.pl error in bcm2835.c

ERROR: do not initialise statics to NULL

Signed-off-by: William Stevenson <yhvh2000@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.c b/drivers/staging/bcm2835-audio/bcm2835.c
index a84d74daccbc..265fe5565f42 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/bcm2835-audio/bcm2835.c
@@ -28,8 +28,8 @@
  * to debug if we run into issues
  */
 
-static struct snd_card *g_card = NULL;
-static struct bcm2835_chip *g_chip = NULL;
+static struct snd_card *g_card;
+static struct bcm2835_chip *g_chip;
 
 static int snd_bcm2835_free(struct bcm2835_chip *chip)
 {
-- 
2.11.1
