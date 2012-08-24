From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 11:33:47 +0800
Subject: [PATCH] ARM: imx: fix imx51 babbage SD2 CD/WP
Message-ID: <1345779227-3700-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pads GPIO1_6 and GPIO1_5 are used as SD2 CD/WP on imx51 babbage board.
Before commit 5d23b39 (ARM: i.MX51 iomux: add missed definitions for
SION-bit and mode for some pads) gets in, we use the pad settings
configured by bootloader with NO_PAD_CTRL and SD2 CD/WP just works.
The commit changes the pad settings and causes SD2 CD/WP stop working.

Set up pads GPIO1_6 and GPIO1_5 in the configuation that bootloader
uses on imx51 babbage board to fix the SD2 CD/WP regression.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-mx51_babbage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index 7b31cbd..83f49c4 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -154,8 +154,8 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_SD2_DATA2__SD2_DATA2,
 	MX51_PAD_SD2_DATA3__SD2_DATA3,
 	/* CD/WP gpio */
-	MX51_PAD_GPIO1_6__GPIO1_6,
-	MX51_PAD_GPIO1_5__GPIO1_5,
+	NEW_PAD_CTRL(MX51_PAD_GPIO1_6__GPIO1_6, PAD_CTL_HYS),
+	NEW_PAD_CTRL(MX51_PAD_GPIO1_5__GPIO1_5, PAD_CTL_HYS),
 
 	/* eCSPI1 */
 	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
-- 
1.7.5.4
