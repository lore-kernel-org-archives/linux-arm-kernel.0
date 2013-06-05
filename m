From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:21 +0900
Subject: [PATCH 090/130] ARM: shmobile: r8a7740: Remove GETHER function GPIOs
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-91-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 61cff39..0db82aa 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -331,29 +331,6 @@ enum {
 	GPIO_FN_IDE_INT,	GPIO_FN_IDE_RST,	GPIO_FN_IDE_DIRECTION,
 	GPIO_FN_IDE_EXBUF_ENB,	GPIO_FN_IDE_IODACK,	GPIO_FN_IDE_IODREQ,
 
-	/* RMII */
-	GPIO_FN_RMII_CRS_DV,	GPIO_FN_RMII_RX_ER,	GPIO_FN_RMII_RXD0,
-	GPIO_FN_RMII_RXD1,	GPIO_FN_RMII_TX_EN,	GPIO_FN_RMII_TXD0,
-	GPIO_FN_RMII_MDC,	GPIO_FN_RMII_TXD1,	GPIO_FN_RMII_MDIO,
-	GPIO_FN_RMII_REF50CK,	/* for RMII */
-	GPIO_FN_RMII_REF125CK,	/* for GMII */
-
-	/* GEther */
-	GPIO_FN_ET_TX_CLK,	GPIO_FN_ET_TX_EN,	GPIO_FN_ET_ETXD0,
-	GPIO_FN_ET_ETXD1,	GPIO_FN_ET_ETXD2,	GPIO_FN_ET_ETXD3,
-	GPIO_FN_ET_ETXD4,	GPIO_FN_ET_ETXD5, /* for GEther */
-	GPIO_FN_ET_ETXD6,	GPIO_FN_ET_ETXD7, /* for GEther */
-	GPIO_FN_ET_COL,		GPIO_FN_ET_TX_ER,
-	GPIO_FN_ET_RX_CLK,	GPIO_FN_ET_RX_DV,
-	GPIO_FN_ET_ERXD0,	GPIO_FN_ET_ERXD1,
-	GPIO_FN_ET_ERXD2,	GPIO_FN_ET_ERXD3,
-	GPIO_FN_ET_ERXD4,	GPIO_FN_ET_ERXD5, /* for GEther */
-	GPIO_FN_ET_ERXD6,	GPIO_FN_ET_ERXD7, /* for GEther */
-	GPIO_FN_ET_RX_ER,	GPIO_FN_ET_CRS,
-	GPIO_FN_ET_MDC,		GPIO_FN_ET_MDIO,
-	GPIO_FN_ET_LINK,	GPIO_FN_ET_PHY_INT,
-	GPIO_FN_ET_WOL,		GPIO_FN_ET_GTX_CLK,
-
 	/* DMA0 */
 	GPIO_FN_DREQ0,		GPIO_FN_DACK0,
 
-- 
1.8.2.1
