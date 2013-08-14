From: joelf@ti.com (Joel Fernandes)
Date: Wed, 14 Aug 2013 18:12:46 -0500
Subject: [PATCH 07/10] crypto: omap-aes: Add IRQ info and helper macros
In-Reply-To: <1376521969-16807-1-git-send-email-joelf@ti.com>
References: <1376521969-16807-1-git-send-email-joelf@ti.com>
Message-ID: <1376521969-16807-8-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IRQ information to pdata and helper macros. These are
required for PIO-mode support.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/crypto/omap-aes.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 71da52b..c057eac 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -82,6 +82,10 @@
 
 #define AES_REG_LENGTH_N(x)		(0x54 + ((x) * 0x04))
 
+#define AES_REG_IRQ_STATUS(dd)         ((dd)->pdata->irq_status_ofs)
+#define AES_REG_IRQ_ENABLE(dd)         ((dd)->pdata->irq_enable_ofs)
+#define AES_REG_IRQ_DATA_IN            BIT(1)
+#define AES_REG_IRQ_DATA_OUT           BIT(2)
 #define DEFAULT_TIMEOUT		(5*HZ)
 
 #define FLAGS_MODE_MASK		0x000f
@@ -127,6 +131,8 @@ struct omap_aes_pdata {
 	u32		data_ofs;
 	u32		rev_ofs;
 	u32		mask_ofs;
+	u32             irq_enable_ofs;
+	u32             irq_status_ofs;
 
 	u32		dma_enable_in;
 	u32		dma_enable_out;
@@ -846,6 +852,8 @@ static const struct omap_aes_pdata omap_aes_pdata_omap4 = {
 	.data_ofs	= 0x60,
 	.rev_ofs	= 0x80,
 	.mask_ofs	= 0x84,
+	.irq_status_ofs = 0x8c,
+	.irq_enable_ofs = 0x90,
 	.dma_enable_in	= BIT(5),
 	.dma_enable_out	= BIT(6),
 	.major_mask	= 0x0700,
-- 
1.7.9.5
