From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:47 +0200
Subject: [PATCH 3/6] ARM: ux500: Enable support for RPMB and Reliable Write
 for eMMC
In-Reply-To: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369314830-3727-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

By adding MMC_CAP_CMD23 for the eMMC devices, we can support RPMB
and Reliable Write. Additionally it will mean CMD12 will not be sent
to end a successful data transfer.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index c0573d2..9bb3ca5 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -143,8 +143,10 @@ static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
 struct mmci_platform_data mop500_sdi2_data = {
 	.ocr_mask	= MMC_VDD_165_195,
 	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
-			  MMC_CAP_MMC_HIGHSPEED,
+	.capabilities	= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_8_BIT_DATA |
+				MMC_CAP_MMC_HIGHSPEED |
+				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
 #ifdef CONFIG_STE_DMA40
@@ -180,8 +182,10 @@ static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
 
 struct mmci_platform_data mop500_sdi4_data = {
 	.f_max		= 100000000,
-	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
-			  MMC_CAP_MMC_HIGHSPEED,
+	.capabilities	= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_8_BIT_DATA |
+				MMC_CAP_MMC_HIGHSPEED |
+				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
 #ifdef CONFIG_STE_DMA40
-- 
1.7.10
