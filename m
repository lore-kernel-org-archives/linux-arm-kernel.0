From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 18 Dec 2009 18:11:33 +0100
Subject: [PATCH 2/2] mx31moboard: boot_on/always_on voltage regulators hang
	kernel at boot
In-Reply-To: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1261156293-13981-3-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 88532b8..b4baf30 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -184,7 +184,7 @@ static struct regulator_init_data sdhc_vreg_data = {
 		.valid_modes_mask = REGULATOR_MODE_NORMAL |
 			REGULATOR_MODE_FAST,
 		.always_on = 0,
-		.boot_on = 1,
+		.boot_on = 0,
 	},
 	.num_consumer_supplies = ARRAY_SIZE(sdhc_consumers),
 	.consumer_supplies = sdhc_consumers,
@@ -206,7 +206,7 @@ static struct regulator_init_data cam_vreg_data = {
 		.valid_modes_mask = REGULATOR_MODE_NORMAL |
 			REGULATOR_MODE_FAST,
 		.always_on = 0,
-		.boot_on = 1,
+		.boot_on = 0,
 	},
 	.num_consumer_supplies = ARRAY_SIZE(cam_consumers),
 	.consumer_supplies = cam_consumers,
-- 
1.6.3.3
