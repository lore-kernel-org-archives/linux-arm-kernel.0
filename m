From: prakity@marvell.com (Philip Rakity)
Date: Fri, 21 Jan 2011 11:19:36 -0800
Subject: [PATCH] mach-mmp: Support for SD/MMC clock adjustment in brownstone
Message-ID: <E105BE08-7F36-4121-AFF2-079797C0BC92@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set timing for brownstone for SD/MMC cards to enable detection
timing adjustments are needed when speed > 25MHz
remove limitation on maximum speed of 25MHz

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 75b4f63..38f196f 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -177,14 +177,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
-	.max_speed	= 25000000,
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 15,
 	.flags		= PXA_FLAG_CARD_PERMANENT,
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 	.flags		= PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
-- 
1.7.0.4
