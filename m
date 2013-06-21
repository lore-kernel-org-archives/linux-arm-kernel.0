From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:27:38 +0200
Subject: [PATCH 1/2] staging: drm/imx: fix number of IPU IRQs
In-Reply-To: <1371803259-18369-1-git-send-email-p.zabel@pengutronix.de>
References: <1371803259-18369-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371803259-18369-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 15 32-bit registers altogether.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
index 5518028..12d7eaf 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
@@ -110,7 +110,7 @@ struct ipu_soc;
 #define IDMAC_BAND_EN(ch)		IPU_IDMAC_REG(0x0040 + 4 * ((ch) / 32))
 #define IDMAC_CHA_BUSY(ch)		IPU_IDMAC_REG(0x0100 + 4 * ((ch) / 32))
 
-#define IPU_NUM_IRQS	(32 * 5)
+#define IPU_NUM_IRQS	(32 * 15)
 
 enum ipu_modules {
 	IPU_CONF_CSI0_EN		= (1 << 0),
-- 
1.8.3.1
