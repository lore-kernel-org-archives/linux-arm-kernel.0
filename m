From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 19 Nov 2009 15:15:21 +0100
Subject: [PATCH 1/1] mx31moboard: change initial reset status for robot
	microcontolers
Message-ID: <1258640121-12637-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want the microcontrolers to be held in reset during kernel boot.

This patch is trivial and should go into next -rc.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-marxbot.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 2bfaffb..325e10b 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -110,12 +110,12 @@ static struct imxmmc_platform_data sdhc2_pdata = {
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
-- 
1.6.3.3
