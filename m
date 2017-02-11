From: manchoyy@gmail.com (Man Choy)
Date: Sun, 12 Feb 2017 04:34:09 +0800
Subject: [PATCH] bcm2835-audio: Fix checkpatch errors
Message-ID: <1486845362-25086-1-git-send-email-manchoyy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following errors:

ERROR: do not initialise statics to NULL
+static struct snd_card *g_card = NULL;

ERROR: do not initialise statics to NULL
+static struct bcm2835_chip *g_chip = NULL;

Signed-off-by: Man Choy <manchoyy@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.c b/drivers/staging/bcm2835-audio/bcm2835.c
index a84d74d..265fe55 100644
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
2.7.4
