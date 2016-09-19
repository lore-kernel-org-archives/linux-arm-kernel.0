From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Sep 2016 17:00:41 +0800
Subject: [PATCH] spi: dw: use relaxed IO accessor
Message-ID: <20160919090041.4024-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the __raw functions is discouraged.  Update the driver to use the
relaxed functions.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/spi/spi-dw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 61bc3cb..2cfdc4d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -143,22 +143,22 @@ struct dw_spi {
 
 static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
 {
-	return __raw_readl(dws->regs + offset);
+	return readl_relaxed(dws->regs + offset);
 }
 
 static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
 {
-	return __raw_readw(dws->regs + offset);
+	return readw_relaxed(dws->regs + offset);
 }
 
 static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
 {
-	__raw_writel(val, dws->regs + offset);
+	writel_relaxed(val, dws->regs + offset);
 }
 
 static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
 {
-	__raw_writew(val, dws->regs + offset);
+	writew_relaxed(val, dws->regs + offset);
 }
 
 static inline u32 dw_read_io_reg(struct dw_spi *dws, u32 offset)
-- 
2.9.3
