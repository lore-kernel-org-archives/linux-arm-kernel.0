From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:13 +0000
Subject: [PATCH 16/46] ARM: ux500: Add supply for the Cypress TrueTouch
 Touchscreen
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch lists the Cypress TrueTouch Touchscreen as a consumer
of the AB8500 VAUX1 regulator.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index ce2ae47..3d63c8d 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -79,6 +79,8 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdd", "3-0029"),
 	/* Pressure sensor device */
 	REGULATOR_SUPPLY("vdd", "2-005c"),
+	/* Cypress TrueTouch Touchscreen device */
+	REGULATOR_SUPPLY("vcpin", "spi8.0"),
 };
 
 static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
-- 
1.7.10.4
