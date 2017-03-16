From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 16 Mar 2017 21:29:03 +0800
Subject: [PATCH] mmc: sunxi: change controller error info to debug level
Message-ID: <20170316132903.61246-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The controller's errors are usually normal (for example, for MMC or SDIO
cards, some errors are expected to happen; and for boards without a
dedicated card detect pin the error info will even flood console and
hide other normal messages) and hard to understand.

Change their print level to debug, thus it won't be shown to generic
users.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6ffcd2838272..0391c62cc99f 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -489,7 +489,7 @@ static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *host)
 				      cmd->opcode == SD_IO_RW_DIRECT))
 		return;
 
-	dev_err(mmc_dev(host->mmc),
+	dev_dbg(mmc_dev(host->mmc),
 		"smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n",
 		host->mmc->index, cmd->opcode,
 		data ? (data->flags & MMC_DATA_WRITE ? " WR" : " RD") : "",
-- 
2.12.0
