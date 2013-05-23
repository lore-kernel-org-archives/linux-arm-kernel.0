From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:48 +0200
Subject: [PATCH 4/6] ARM: ux500: Enable support for discard for MMC/SD
In-Reply-To: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369314830-3727-5-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

By enabling MMC_CAP_ERASE for the SD/MMC devices the mmc block
layer will now act on DISCARD requests.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 9bb3ca5..3c07f55 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -55,7 +55,8 @@ struct mmci_platform_data mop500_sdi0_data = {
 	.f_max		= 100000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_SD_HIGHSPEED |
-				MMC_CAP_MMC_HIGHSPEED,
+				MMC_CAP_MMC_HIGHSPEED |
+				MMC_CAP_ERASE,
 	.gpio_wp	= -1,
 	.sigdir		= MCI_ST_FBCLKEN |
 				MCI_ST_CMDDIREN |
@@ -146,6 +147,7 @@ struct mmci_platform_data mop500_sdi2_data = {
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_8_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED |
+				MMC_CAP_ERASE |
 				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
@@ -185,6 +187,7 @@ struct mmci_platform_data mop500_sdi4_data = {
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_8_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED |
+				MMC_CAP_ERASE |
 				MMC_CAP_CMD23,
 	.gpio_cd	= -1,
 	.gpio_wp	= -1,
-- 
1.7.10
