From: prakity@marvell.com (Philip Rakity)
Date: Sun, 13 Feb 2011 22:56:22 -0800
Subject: [PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in
	brownstone
Message-ID: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
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
index 0e92fd7..35afe60 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
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
