From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Sep 2015 17:30:24 +0200
Subject: [PATCH 1/3] mmc: Add mmc_is_io_op helper function
In-Reply-To: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442935826-16758-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper function to check if an opcode is a sd-io-rw-* opcode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/core/sdio_ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index 12a4d3a..5660c7f 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -12,6 +12,8 @@
 #ifndef _MMC_SDIO_OPS_H
 #define _MMC_SDIO_OPS_H
 
+#include <linux/mmc/sdio.h>
+
 int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, u8 in, u8* out);
@@ -19,5 +21,10 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
 int sdio_reset(struct mmc_host *host);
 
+static inline bool mmc_is_io_op(u32 opcode)
+{
+	return opcode == SD_IO_RW_DIRECT || opcode == SD_IO_RW_EXTENDED;
+}
+
 #endif
 
-- 
2.4.3
