From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Apr 2016 14:11:55 +0100
Subject: [PATCH] ARM: vexpress/spc: remove unused variable perf_stat_reg
In-Reply-To: <DUB128-W495B590F6B8E0BF405721B9C620@phx.gbl>
References: <DUB128-W495B590F6B8E0BF405721B9C620@phx.gbl>
Message-ID: <1461676315-3992-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable 'perf_stat_reg' in ve_spc_set_performance is assigned a
value but that is never used.

So let's remove the variable 'perf_stat_reg'

Reported-by: David Binderman <dcb314@hotmail.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-vexpress/spc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 5766ce2be32b..0d89257ddc0a 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -319,17 +319,15 @@ static int ve_spc_waitforcompletion(int req_type)
 
 static int ve_spc_set_performance(int cluster, u32 freq)
 {
-	u32 perf_cfg_reg, perf_stat_reg;
+	u32 perf_cfg_reg;
 	int ret, perf, req_type;
 
 	if (cluster_is_a15(cluster)) {
 		req_type = CA15_DVFS;
 		perf_cfg_reg = PERF_LVL_A15;
-		perf_stat_reg = PERF_REQ_A15;
 	} else {
 		req_type = CA7_DVFS;
 		perf_cfg_reg = PERF_LVL_A7;
-		perf_stat_reg = PERF_REQ_A7;
 	}
 
 	perf = ve_spc_find_performance_index(cluster, freq);
-- 
1.9.1
