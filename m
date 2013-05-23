From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:46 +0200
Subject: [PATCH 2/6] ARM: ux500: Don't set plf ocr mask for SD/MMC device
In-Reply-To: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369314830-3727-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The mmci host driver overrides platform ocr mask when a vmmc regulator
can be used. This is the case for sdi0(SD-card) and for sdi4(eMMC).
Thus it is pointless of specifing these mask and why we do remove them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index eb9b2de..c0573d2 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -52,7 +52,6 @@ static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 #endif
 
 struct mmci_platform_data mop500_sdi0_data = {
-	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_SD_HIGHSPEED |
@@ -180,7 +179,6 @@ static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
 #endif
 
 struct mmci_platform_data mop500_sdi4_data = {
-	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_MMC_HIGHSPEED,
-- 
1.7.10
