From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri,  1 Dec 2017 11:47:22 +0100
Subject: [PATCH 2/2] ahci: mtk: Change driver name to ahci-mtk
Message-ID: <20171201104722.17353-1-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver name "ahci" is already used by the ahci platform driver.
This leads to the following error:
Error: Driver 'ahci' is already registered, aborting...

Change the name to ahci-mtk to fix this.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/ata/ahci_mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 80854f71559a..22efb9370d1d 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -25,7 +25,7 @@
 #include <linux/reset.h>
 #include "ahci.h"
 
-#define DRV_NAME		"ahci"
+#define DRV_NAME		"ahci-mtk"
 
 #define SYS_CFG			0x14
 #define SYS_CFG_SATA_MSK	GENMASK(31, 30)
-- 
2.12.3
