From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:13 -0300
Subject: [PATCH v3 06/28] mtd: nand: pxa3xx: Prevent sub-page writes
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current driver doesn't support sub-page writing, so report
that to the NAND core.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 64c258e..3765e4e 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1143,6 +1143,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		chip->read_byte		= pxa3xx_nand_read_byte;
 		chip->read_buf		= pxa3xx_nand_read_buf;
 		chip->write_buf		= pxa3xx_nand_write_buf;
+		chip->options		|= NAND_NO_SUBPAGE_WRITE;
 	}
 
 	spin_lock_init(&chip->controller->lock);
-- 
1.8.1.5
