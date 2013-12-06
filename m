From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Dec 2013 13:33:50 -0700
Subject: [PATCH] ARM: tegra: add missing break to fuse initialization code
Message-ID: <1386362030-29187-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add a missing break to the switch in tegra_init_fuse() which determines
which SoC the code is running on. This prevents the Tegra30+ fuse
handling code from running on Tegra20.

Fixes: 3bd1ae57f7bb ("ARM: tegra: add fuses as device randomness")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This is a fix for 3.13.

 arch/arm/mach-tegra/fuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 9a4e910c3796..13995b0be9d9 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -198,6 +198,7 @@ void __init tegra_init_fuse(void)
 	switch (tegra_chip_id) {
 	case TEGRA20:
 		tegra20_fuse_init_randomness();
+		break;
 	case TEGRA30:
 	case TEGRA114:
 	default:
-- 
1.8.1.5
