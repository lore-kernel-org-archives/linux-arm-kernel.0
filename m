From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 8 Oct 2010 09:02:38 +0200
Subject: [PATCH 1/2] MMCI: add some register defines for ST Micro variants
Message-ID: <1286521358-11770-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a few registers to the MMCI/PL180 derivates that
is used for some odd control stuff like SDIO.

Signed-off-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.h |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index acac081..690f2c6 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -54,10 +54,16 @@
 #define MCI_DPSM_MODE		(1 << 2)
 #define MCI_DPSM_DMAENABLE	(1 << 3)
 #define MCI_DPSM_BLOCKSIZE	(1 << 4)
-#define MCI_DPSM_RWSTART	(1 << 8)
-#define MCI_DPSM_RWSTOP		(1 << 9)
-#define MCI_DPSM_RWMOD		(1 << 10)
-#define MCI_DPSM_SDIOEN		(1 << 11)
+/* Control register extensions in the ST Micro U300 and Ux500 versions */
+#define MCI_ST_DPSM_RWSTART	(1 << 8)
+#define MCI_ST_DPSM_RWSTOP	(1 << 9)
+#define MCI_ST_DPSM_RWMOD	(1 << 10)
+#define MCI_ST_DPSM_SDIOEN	(1 << 11)
+/* Control register exeensions in the ST Micro Ux500 versions */
+#define MCI_ST_DPSM_DMAREQCTL	(1 << 12)
+#define MCI_ST_DPSM_DBOOTMODEEN	(1 << 13)
+#define MCI_ST_DPSM_BUSYMODE	(1 << 14)
+#define MCI_ST_DPSM_DDRMODE	(1 << 15)
 
 #define MMCIDATACNT		0x030
 #define MMCISTATUS		0x034
-- 
1.6.3.3
