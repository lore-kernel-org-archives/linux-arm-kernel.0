From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:12 -0300
Subject: [PATCH v4 08/31] mtd: nand: pxa3xx: Prevent sub-page writes
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current driver doesn't support sub-page writing, so report
that to the NAND core.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 3359047..c578ca7 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1145,6 +1145,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		chip->read_byte		= pxa3xx_nand_read_byte;
 		chip->read_buf		= pxa3xx_nand_read_buf;
 		chip->write_buf		= pxa3xx_nand_write_buf;
+		chip->options		|= NAND_NO_SUBPAGE_WRITE;
 	}
 
 	spin_lock_init(&chip->controller->lock);
-- 
1.8.1.5
