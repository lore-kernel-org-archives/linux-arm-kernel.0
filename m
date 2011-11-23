From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 17:53:51 -0700
Subject: [PATCH] arm/tegra: Fix build error with tegra_assert_system_reset
Message-ID: <1322009631-711-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build error:

error: static declaration of 'tegra_assert_system_reset' follows non-static
declaration

Fix:

Remove the non-static declaration; the function should be local now.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 1d14df7..f159577 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -23,8 +23,6 @@
 
 #include <linux/types.h>
 
-void tegra_assert_system_reset(char mode, const char *cmd);
-
 void __init tegra_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
-- 
1.7.0.4
