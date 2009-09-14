From: s-ghorai@ti.com (Sukumar Ghorai)
Date: Mon, 14 Sep 2009 14:28:01 +0530
Subject: [PATCH] There is small problem to support the MMC card >4 GByte.
Message-ID: <mailman.10.1253362965.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXT_CSD_REV could be any value <=3D2 and are valid as per MMCA Specificatio=
n. And it was checking for CSD_STRUCTURE filed of EXT_CSD register.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mmc/core/mmc.c  |    2 +-
 include/linux/mmc/mmc.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 06084db..7b22a2e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -216,7 +216,7 @@ static int mmc_read_ext_csd(struct mmc_card *card)
                goto out;
        }

-       if (ext_csd_struct >=3D 2) {
+       if (ext_csd[EXT_CSD_STRUCT_REV] >=3D 2) {
                card->ext_csd.sectors =3D
                        ext_csd[EXT_CSD_SEC_CNT + 0] << 0 |
                        ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 14b81f3..c4e97a9 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -252,6 +252,7 @@ struct _mmc_csd {
 #define EXT_CSD_BUS_WIDTH      183     /* R/W */
 #define EXT_CSD_HS_TIMING      185     /* R/W */
 #define EXT_CSD_CARD_TYPE      196     /* RO */
+#define EXT_CSD_STRUCT_REV 194     /* RO */
 #define EXT_CSD_REV            192     /* RO */
 #define EXT_CSD_SEC_CNT                212     /* RO, 4 bytes */

--
1.5.4.7

Thanks Regards,
Ghorai
