From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:10 +0000
Subject: [PATCH 13/46] ARM: ux500: Add supply for the L3G4200D Gyroscope
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch lists the L3G4200D Gyroscope as a consumer of the
AB8500 VAUX1 regulator.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 161edbc7..86c2b53 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -73,6 +73,8 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("avdd", "3-005d"),
 	/* Synaptics RMI4 Touchscreen device */
 	REGULATOR_SUPPLY("vdd", "3-004b"),
+	/* L3G4200D Gyroscope device */
+	REGULATOR_SUPPLY("vdd", "2-0068"),
 };
 
 static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
-- 
1.7.10.4
