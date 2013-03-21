From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:21 +0000
Subject: [PATCH 24/46] ARM: ux500: regulator: Add accelerometer and fix
 magnetometer supply device ID
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-25-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the LSM303DLHC Accelerometer to the list of VAUX1
consumers, as well as amending the already added LSM303DLHC
Magnetometer's device ID.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 4f880df..8161519 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -67,8 +67,10 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vcc", "2-0029"),
 	/* lsm303dlh accelerometer */
 	REGULATOR_SUPPLY("vdd", "3-0018"),
+	/* lsm303dlhc accelerometer */
+	REGULATOR_SUPPLY("vdd", "2-0019"),
 	/* lsm303dlh magnetometer */
-	REGULATOR_SUPPLY("vdd", "3-001e"),
+	REGULATOR_SUPPLY("vdd", "2-001e"),
 	/* Rohm BU21013 Touchscreen devices */
 	REGULATOR_SUPPLY("avdd", "3-005c"),
 	REGULATOR_SUPPLY("avdd", "3-005d"),
-- 
1.7.10.4
