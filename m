From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:45 +0200
Subject: [PATCH 1/6] ARM: ux500: Enable 100MHz for SD/SDIO/MMC devices
In-Reply-To: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369314830-3727-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

We are able to cope with an SDMMC clock of 100MHz so let's
make use of the full frequency instead of the half.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 0ef3877..eb9b2de 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -53,7 +53,7 @@ static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 
 struct mmci_platform_data mop500_sdi0_data = {
 	.ocr_mask	= MMC_VDD_29_30,
-	.f_max		= 50000000,
+	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_MMC_HIGHSPEED,
@@ -106,7 +106,7 @@ static struct stedma40_chan_cfg sdi1_dma_cfg_tx = {
 
 struct mmci_platform_data mop500_sdi1_data = {
 	.ocr_mask	= MMC_VDD_29_30,
-	.f_max		= 50000000,
+	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
@@ -143,7 +143,7 @@ static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
 
 struct mmci_platform_data mop500_sdi2_data = {
 	.ocr_mask	= MMC_VDD_165_195,
-	.f_max		= 50000000,
+	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_MMC_HIGHSPEED,
 	.gpio_cd	= -1,
@@ -181,7 +181,7 @@ static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
 
 struct mmci_platform_data mop500_sdi4_data = {
 	.ocr_mask	= MMC_VDD_29_30,
-	.f_max		= 50000000,
+	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_MMC_HIGHSPEED,
 	.gpio_cd	= -1,
-- 
1.7.10
