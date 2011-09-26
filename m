From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Mon, 26 Sep 2011 10:45:37 +0300
Subject: [PATCH resend 01/13] omap: mcbsp: Remove unused variables from
	platform data
In-Reply-To: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1317023150-6730-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <1317023150-6730-2-git-send-email-jarkko.nikula@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These variables got unused after McBSP was converted to use resource
structures.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
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
1.7.6.3
