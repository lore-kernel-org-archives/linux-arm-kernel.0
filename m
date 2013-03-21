From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:11 +0000
Subject: [PATCH 14/46] ARM: ux500: Add supply for the Ambient light sensor
 device
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch lists the Ambient light sensor device as a consumer
of the AB8500 VAUX1 regulator.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 86c2b53..b3d4747 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -75,6 +75,8 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdd", "3-004b"),
 	/* L3G4200D Gyroscope device */
 	REGULATOR_SUPPLY("vdd", "2-0068"),
+	/* Ambient light sensor device */
+	REGULATOR_SUPPLY("vdd", "3-0029"),
 };
 
 static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
-- 
1.7.10.4
