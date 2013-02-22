From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 22 Feb 2013 14:24:25 +0800
Subject: [PATCH 1/3] ARM: tegra: Fix unchecked return value
Message-ID: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi Doyu <hdoyu@nvidia.com>

Check a return value for tegra_powergate_remove_clamping().

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 2c6b3d5..4dfc75e 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -124,6 +124,9 @@ remove_clamps:
 
 	/* Remove I/O clamps. */
 	ret = tegra_powergate_remove_clamping(pwrgateid);
+	if (ret)
+		return ret;
+
 	udelay(10);
 
 	/* Clear flow controller CSR. */
-- 
1.8.1.1
