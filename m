From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 10 Jul 2018 08:29:02 -0500
Subject: [PATCH] mtd: nuc900_nand: mark expected switch fall-through
Message-ID: <20180710132902.GA13541@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1471717 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/nand/raw/nuc900_nand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index af5b32c9..53a9f6c 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -191,8 +191,9 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
 		return;
 
 	case NAND_CMD_READ0:
-
 		write_cmd_reg(nand, NAND_CMD_READSTART);
+		/* fall through */
+
 	default:
 
 		if (!chip->dev_ready) {
-- 
2.7.4
