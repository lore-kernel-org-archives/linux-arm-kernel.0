From: prakity@marvell.com (Philip Rakity)
Date: Fri, 22 Apr 2011 13:13:28 -0700
Subject: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
Message-ID: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
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
index 1ab332e..dd1ce96 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -30,6 +30,9 @@ struct sdhci_pxa_platdata {
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
