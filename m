From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 30 Aug 2017 22:17:51 +0530
Subject: [PATCH] ARM: mxs: constify platform_suspend_ops
Message-ID: <be1c12e8040201dcabec64561ec6e446e2111b1e.1504111357.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_suspend_ops are not supposed to change at runtime.
Functions suspend_set_ops working with const platform_suspend_ops.
So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm/mach-mxs/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
index 0170e99..6ae057c 100644
--- a/arch/arm/mach-mxs/pm.c
+++ b/arch/arm/mach-mxs/pm.c
@@ -30,7 +30,7 @@ static int mxs_suspend_enter(suspend_state_t state)
 	return 0;
 }
 
-static struct platform_suspend_ops mxs_suspend_ops = {
+static const struct platform_suspend_ops mxs_suspend_ops = {
 	.enter = mxs_suspend_enter,
 	.valid = suspend_valid_only_mem,
 };
-- 
2.7.4
