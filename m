From: craigkewley@gmail.com (Craig Kewley)
Date: Tue, 31 Jan 2017 22:22:32 +0000
Subject: [PATCH] staging: bcm2835: do not initialise statics to NULL
Message-ID: <20170131222232.42062-1-craigkewley@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl warning:

ERROR: do not initialise statics to NULL

Signed-off-by: Craig Kewley <craigkewley@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.c b/drivers/staging/bcm2835-audio/bcm2835.c
index 9e3b248c7085..6932492e1834 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/bcm2835-audio/bcm2835.c
@@ -34,8 +34,8 @@ static int enable[MAX_SUBSTREAMS] = {[0 ... (MAX_SUBSTREAMS - 1)] = 1};
  * to debug if we run into issues
  */
 
-static struct snd_card *g_card = NULL;
-static struct bcm2835_chip *g_chip = NULL;
+static struct snd_card *g_card;
+static struct bcm2835_chip *g_chip;
 
 static int snd_bcm2835_free(struct bcm2835_chip *chip)
 {
-- 
2.11.0
