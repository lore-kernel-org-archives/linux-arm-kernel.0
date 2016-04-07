From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Thu, 7 Apr 2016 20:09:28 +0530
Subject: [LINUX PATCH v2 2/3] mtd:m25p80: Assigned number of dummy cycles to
 dummy_cycles.
In-Reply-To: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <1460039969-9835-2-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assigned number of dummy cycles to dummy_cycles member of
spi_transfer structure in m25p80_read API.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
v2: 
 - New Patch.
 
 drivers/mtd/devices/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c9c3b7f..7c9fac9 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -139,6 +139,7 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 
 	t[0].tx_buf = flash->command;
 	t[0].len = m25p_cmdsz(nor) + dummy;
+	t[0].dummy = nor->read_dummy;
 	spi_message_add_tail(&t[0], &m);
 
 	t[1].rx_buf = buf;
-- 
2.1.2
