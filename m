From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue,  9 Feb 2010 18:13:34 +0100
Subject: [PATCH 1/3] mx31moboard: change initial reset status for robot
	microcontollers
In-Reply-To: <1265735616-476-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1265735616-476-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1265735616-476-2-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want the microcontrollers to be held in reset during kernel boot.

We also set the turretcam as the default camera since it is present on all
marxbots.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-marxbot.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 1f44b9c..7f6f58c 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -127,12 +127,12 @@ static struct imxmmc_platform_data sdhc2_pdata = {
 static void dspics_resets_init(void)
 {
 	if (!gpio_request(TRSLAT_RST_B, "translator-rst")) {
-		gpio_direction_output(TRSLAT_RST_B, 1);
+		gpio_direction_output(TRSLAT_RST_B, 0);
 		gpio_export(TRSLAT_RST_B, false);
 	}
 
 	if (!gpio_request(DSPICS_RST_B, "dspics-rst")) {
-		gpio_direction_output(DSPICS_RST_B, 1);
+		gpio_direction_output(DSPICS_RST_B, 0);
 		gpio_export(DSPICS_RST_B, false);
 	}
 }
@@ -200,7 +200,7 @@ static int __init marxbot_cam_init(void)
 	int ret = gpio_request(CAM_CHOICE, "cam-choice");
 	if (ret)
 		return ret;
-	gpio_direction_output(CAM_CHOICE, 1);
+	gpio_direction_output(CAM_CHOICE, 0);
 
 	ret = gpio_request(BASECAM_RST_B, "basecam-reset");
 	if (ret)
-- 
1.6.3.3
