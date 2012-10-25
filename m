From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 25 Oct 2012 10:35:01 -0700
Subject: [PATCH] ARM: OMAP2+: PM: add missing newline to VC warning message
Message-ID: <1351186501-32223-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

Add missing newline to warning message to avoid annoying
wrapping problems during kernel boot like this one:

   omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
   omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 880249b..75878c3 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -264,7 +264,7 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
 
 	if (initialized) {
 		if (voltdm->pmic->i2c_high_speed != i2c_high_speed)
-			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).",
+			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).\n",
 				__func__, voltdm->name, i2c_high_speed);
 		return;
 	}
-- 
1.8.0
