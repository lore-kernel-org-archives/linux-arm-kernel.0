From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Thu, 22 Nov 2018 05:14:37 +0000
Subject: [PATCH v4 2/7] spi: spi-mem: add support for octo mode I/O data
 transfer
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1542863544-21257-3-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for octo mode I/O data transfer in spi-mem framework.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Patch added in v2 version.

 drivers/spi/spi-mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 62a7b80..388f849 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -12,7 +12,7 @@
 
 #include "internals.h"
 
-#define SPI_MEM_MAX_BUSWIDTH		4
+#define SPI_MEM_MAX_BUSWIDTH		8
 
 /**
  * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
@@ -121,6 +121,13 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 
 		break;
 
+	case 8:
+		if ((tx && (mode & SPI_TX_OCTO)) ||
+		    (!tx && (mode & SPI_RX_OCTO)))
+			return 0;
+
+		break;
+
 	default:
 		break;
 	}
-- 
2.7.4
