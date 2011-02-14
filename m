From: prakity@marvell.com (Philip Rakity)
Date: Sun, 13 Feb 2011 22:55:45 -0800
Subject: [PATCH 1/2] plat-pxa: Enable ability to adjust SD/MMC clocks
Message-ID: <ADFFF718-5858-412E-94BB-6F696CB5FD31@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
clock.  This feature is useful and required depending on the board
design.  Add infrastructure to support SD clock tuning.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index a5bf405..bae194a 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -31,6 +31,9 @@ struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	quirks;
 	unsigned int	flags;
+	unsigned short	adjust_clocks;
+	unsigned short	clk_select;
+	unsigned short	clk_delay;
 };
 
 #endif /* __PLAT_PXA_SDHCI_H */
-- 
1.7.0.4
