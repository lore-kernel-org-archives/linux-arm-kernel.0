From: nm@ti.com (Nishanth Menon)
Date: Wed,  2 Mar 2011 16:25:16 +0530
Subject: [PATCH v2 03/18] omap3+: voltage: remove spurious pr_notice for
	debugfs
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Message-ID: <1299063331-27968-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cat of debugfs entry for vp_volt provides voltage. The additional pr_notice
is just spam on console and provides no additional information.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 280ee12..992b383 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -347,7 +347,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	}
 
 	vsel = vdd->read_reg(vdd->vp_reg.prm_mod, vdd->vp_offs.voltage);
-	pr_notice("curr_vsel = %x\n", vsel);
 
 	if (!vdd->pmic_info->vsel_to_uv) {
 		pr_warning("PMIC function to convert vsel to voltage"
-- 
1.7.1
