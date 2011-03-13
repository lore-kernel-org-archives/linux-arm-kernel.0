From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 17:19:18 +0200
Subject: [PATCH v2 2/6] ARM: PXA: Z2: Fix battery pdata
In-Reply-To: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
References: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1300029562-8400-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix coefficients to get actual voltage, and make
voltage_max/voltage_min looks like values for LiIon battery.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 19bbb7d..b58274e 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -475,9 +475,9 @@ static struct z2_battery_info batt_chip_info = {
 	.batt_I2C_addr	= 0x55,
 	.batt_I2C_reg	= 2,
 	.charge_gpio	= GPIO0_ZIPITZ2_AC_DETECT,
-	.min_voltage	= 2400000,
-	.max_voltage	= 3700000,
-	.batt_div	= 69,
+	.min_voltage	= 3475000,
+	.max_voltage	= 4190000,
+	.batt_div	= 59,
 	.batt_mult	= 1000000,
 	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LION,
 	.batt_name	= "Z2",
-- 
1.7.4.1
