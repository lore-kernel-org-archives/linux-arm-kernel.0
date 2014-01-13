From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 Jan 2014 15:01:42 -0700
Subject: [PATCH] ARM: tegra: fix tegra_powergate_sequence_power_up() inline
Message-ID: <1389650502-30017-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Remove an invalid semicolon from the inline dummy, thus solving:
In file included from drivers/gpu/drm/tegra/gr3d.c:15:0:
include/linux/tegra-powergate.h:119:1: error: expected identifier or '(' before '{' token

Fixes: 80b28791ff04 ("ARM: tegra: pass reset to tegra_powergate_sequence_power_up()")
Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/linux/tegra-powergate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tegra-powergate.h b/include/linux/tegra-powergate.h
index e6f2ab3014a7..46f0a07812b4 100644
--- a/include/linux/tegra-powergate.h
+++ b/include/linux/tegra-powergate.h
@@ -115,7 +115,7 @@ static inline int tegra_powergate_remove_clamping(int id)
 }
 
 static inline int tegra_powergate_sequence_power_up(int id, struct clk *clk,
-						    struct reset_control *rst);
+						    struct reset_control *rst)
 {
 	return -ENOSYS;
 }
-- 
1.8.1.5
