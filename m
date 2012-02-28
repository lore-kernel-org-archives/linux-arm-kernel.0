From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 28 Feb 2012 15:02:34 +0530
Subject: [PATCH] ARM: OMAP2+: Remove apply_uV constraints for fixed regulator
Message-ID: <1330421554-29369-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VUSB is a fixed regulator, so get rid of the apply_uV constraint
for it, which fixes the following error seen at boot on omap4
SDP and PANDA boards.

machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint
twl_reg twl_reg.46: can't register VUSB, -22
twl_reg: probe of twl_reg.46 failed with error -22

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 10b20c6..4b57757 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -270,7 +270,6 @@ static struct regulator_init_data omap4_vusb_idata = {
 	.constraints = {
 		.min_uV			= 3300000,
 		.max_uV			= 3300000,
-		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-- 
1.7.1
