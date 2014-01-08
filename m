From: broonie@kernel.org (Mark Brown)
Date: Wed,  8 Jan 2014 17:10:13 +0000
Subject: [PATCH 4/4] arm64: topology: Provide relative power numbers for cores
In-Reply-To: <1389201013-23794-1-git-send-email-broonie@kernel.org>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
Message-ID: <1389201013-23794-4-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Provide performance numbers to the scheduler to help it fill the cores in
the system on big.LITTLE systems. With the current scheduler this may
perform poorly for applications that try to do OpenMP style work over all
cores but should help for more common workloads.

The power numbers are the same as for ARMv7 since it seems that the
expected differential between the big and little cores is very similar on
both ARMv7 and ARMv8. These numbers are just an initial and basic
approximation for use with the current scheduler, it is likely that both
experience with silicon and ongoing work on improving the scheduler will
lead to further tuning. In both ARMv7 and ARMv8 cases the numbers were
based on the published DMIPS numbers.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/kernel/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index e5140b03b342..869aeaff02dc 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -183,6 +183,8 @@ struct cpu_efficiency {
  * use the default SCHED_POWER_SCALE value for cpu_scale.
  */
 static const struct cpu_efficiency table_efficiency[] = {
+	{ "arm,cortex-a57", 3891 },
+	{ "arm,cortex-a53", 2048 },
 	{ NULL, },
 };
 
-- 
1.8.5.2
