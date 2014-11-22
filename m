From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 22 Nov 2014 16:21:39 +0100
Subject: [PATCH v3 1/4] spi: core: Add spi_transfer_is_last() helper
In-Reply-To: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1416669702-7841-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the function spi_transfer_is_last() which can be used by
drivers to know whether a given transfer is the last one in the
current message.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 include/linux/spi/spi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 46d188a..a6ef2a8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1049,4 +1049,10 @@ spi_unregister_device(struct spi_device *spi)
 extern const struct spi_device_id *
 spi_get_device_id(const struct spi_device *sdev);
 
+static inline bool
+spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
+{
+	return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
+}
+
 #endif /* __LINUX_SPI_H */
-- 
1.9.1
