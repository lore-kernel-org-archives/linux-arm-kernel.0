From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:49 +0200
Subject: [PATCH 5/6] ARM: ux500: Set eMMC and WLAN card slot as non-removable
In-Reply-To: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369314830-3727-6-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

For several reasons, the mmc protocol layer expects devices
being non-removable to use MMC_CAP_NONREMOVABLE, so then we
adapt to this expectation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 3c07f55..2e341fb 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -107,7 +107,8 @@ static struct stedma40_chan_cfg sdi1_dma_cfg_tx = {
 struct mmci_platform_data mop500_sdi1_data = {
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA,
+	.capabilities	= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_NONREMOVABLE,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
 #ifdef CONFIG_STE_DMA40
@@ -146,6 +147,7 @@ struct mmci_platform_data mop500_sdi2_data = {
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_8_BIT_DATA |
+				MMC_CAP_NONREMOVABLE |
 				MMC_CAP_MMC_HIGHSPEED |
 				MMC_CAP_ERASE |
 				MMC_CAP_CMD23,
@@ -186,6 +188,7 @@ struct mmci_platform_data mop500_sdi4_data = {
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_8_BIT_DATA |
+				MMC_CAP_NONREMOVABLE |
 				MMC_CAP_MMC_HIGHSPEED |
 				MMC_CAP_ERASE |
 				MMC_CAP_CMD23,
-- 
1.7.10
