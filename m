From: nm@ti.com (Nishanth Menon)
Date: Sat,  5 Mar 2011 20:59:07 +0530
Subject: [PATCH V3 04/19] OMAP3+: voltage: remove spurious pr_notice for
	debugfs
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Message-ID: <1299338962-5602-5-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cat of debugfs entry for vp_volt provides voltage. The additional pr_notice
is just spam on console and provides no additional information.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1b40aa0..53c399f 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -150,7 +150,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	}
 
 	vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
-	pr_notice("curr_vsel = %x\n", vsel);
 
 	if (!vdd->pmic_info->vsel_to_uv) {
 		pr_warning("PMIC function to convert vsel to voltage"
-- 
1.7.1
