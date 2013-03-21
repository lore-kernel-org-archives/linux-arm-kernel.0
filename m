From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:05 +0000
Subject: [PATCH 08/46] ARM: ux500: Update displays in vaux1 consumer list
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 3 more specific consumers pertaining to the displays found
on the u8500 and ST User Interface Boards (UIBs).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index da96298..161edbc7 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -54,8 +54,12 @@ struct regulator_init_data tps61052_regulator = {
 };
 
 static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
-	/* External displays, connector on board 2v5 power supply */
-	REGULATOR_SUPPLY("vaux12v5", "mcde.0"),
+	/* Main display, u8500 R3 uib */
+	REGULATOR_SUPPLY("vddi", "mcde_disp_sony_acx424akp.0"),
+	/* Main display, u8500 uib and ST uib */
+	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.0"),
+	/* Secondary display, ST uib */
+	REGULATOR_SUPPLY("vdd1", "samsung_s6d16d0.1"),
 	/* SFH7741 proximity sensor */
 	REGULATOR_SUPPLY("vcc", "gpio-keys.0"),
 	/* BH1780GLS ambient light sensor */
-- 
1.7.10.4
