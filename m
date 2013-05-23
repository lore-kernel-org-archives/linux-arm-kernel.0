From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:50 +0200
Subject: [PATCH 6/6] ARM: ux500: Enable support for UHS-I SD-cards
In-Reply-To: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1369314830-3727-7-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

By setting the host capabilities MMC_CAP_UHS_SDR12|25 for
the SD card device we enable support for UHS cards. The
supported mode is SDR12 and SDR25.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 2e341fb..43be3e0 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -56,7 +56,9 @@ struct mmci_platform_data mop500_sdi0_data = {
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_MMC_HIGHSPEED |
-				MMC_CAP_ERASE,
+				MMC_CAP_ERASE |
+				MMC_CAP_UHS_SDR12 |
+				MMC_CAP_UHS_SDR25,
 	.gpio_wp	= -1,
 	.sigdir		= MCI_ST_FBCLKEN |
 				MCI_ST_CMDDIREN |
-- 
1.7.10
