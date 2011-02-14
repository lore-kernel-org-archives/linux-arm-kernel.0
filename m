From: prakity@marvell.com (Philip Rakity)
Date: Sun, 13 Feb 2011 22:52:03 -0800
Subject: [PATCH 3/5] plat-pxa: sdhci.h define for PERMANENT SD/eMMC/SDIO cards
Message-ID: <29AD1C6B-3E61-45A7-A1E6-D9B869738FB2@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Permanent SD cards are part of the board design.  The mmc layer
when told the card is physically on the board will not poll for
card insert.  Add the define.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..a5bf405 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -17,6 +17,7 @@
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
 
+#define PXA_FLAG_CARD_PERMANENT		(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
 
-- 
1.7.0.4
