From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 18:50:31 +0800
Subject: [PATCH V3 08/14] ARM: pm-imx5: add clk_prepare/clk_unprepare
In-Reply-To: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
References: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321008637-19999-9-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-mx5/pm-imx5.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
index 98052fc..2bdc85f 100644
--- a/arch/arm/mach-mx5/pm-imx5.c
+++ b/arch/arm/mach-mx5/pm-imx5.c
@@ -22,7 +22,7 @@ static struct clk *gpc_dvfs_clk;
 
 static int mx5_suspend_prepare(void)
 {
-	return clk_enable(gpc_dvfs_clk);
+	return clk_prepare_enable(gpc_dvfs_clk);
 }
 
 static int mx5_suspend_enter(suspend_state_t state)
@@ -52,7 +52,7 @@ static int mx5_suspend_enter(suspend_state_t state)
 
 static void mx5_suspend_finish(void)
 {
-	clk_disable(gpc_dvfs_clk);
+	clk_disable_unprepare(gpc_dvfs_clk);
 }
 
 static int mx5_pm_valid(suspend_state_t state)
-- 
1.7.5.4
