From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Wed, 31 Aug 2011 18:22:49 +0300
Subject: [PATCH 02/14] omap: mcbsp: Remove unused variables from platform data
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <1314804181-17260-3-git-send-email-jarkko.nikula@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These variables got unused after McBSP was converted to use resource
structures.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 9882c65..8ab14d8 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -348,14 +348,7 @@ struct omap_mcbsp_ops {
 };
 
 struct omap_mcbsp_platform_data {
-	unsigned long phys_base;
-	u8 dma_rx_sync, dma_tx_sync;
-	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
-#ifdef CONFIG_ARCH_OMAP3
-	/* Sidetone block for McBSP 2 and 3 */
-	unsigned long phys_base_st;
-#endif
 	u16 buffer_size;
 	unsigned int mcbsp_config_type;
 };
-- 
1.7.5.4
