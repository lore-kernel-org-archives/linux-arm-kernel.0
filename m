From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Fri, 20 Jan 2012 09:20:40 +0100
Subject: [PATCH] mach-ux500: sdi: MMC_CAP_SD_HIGHSPEED capability is not yet
 supported on Snowball
Message-ID: <1327047640-15383-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

MMC_CAP_SD_HIGHSPEED is not supported on Snowball board resulting on
initialisation errors.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 4049bd7..1daead3 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -256,6 +256,8 @@ void __init mop500_sdi_init(void)
 
 void __init snowball_sdi_init(void)
 {
+	/* On Snowball MMC_CAP_SD_HIGHSPEED isn't supported (Hardware issue?) */
+	mop500_sdi0_data.capabilities &= ~MMC_CAP_SD_HIGHSPEED;
 	/* On-board eMMC */
 	db8500_add_sdi4(&mop500_sdi4_data, U8500_SDI_V2_PERIPHID);
 	/* External Micro SD slot */
-- 
1.7.6
