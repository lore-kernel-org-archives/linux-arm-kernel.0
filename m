From: juri.lelli@arm.com (Juri Lelli)
Date: Wed,  3 Feb 2016 11:59:57 +0000
Subject: [PATCH v3 4/6] arm64: Enable dynamic CPU capacity initialization
In-Reply-To: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Message-ID: <1454500799-18451-5-git-send-email-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define arch_wants_init_cpu_capacity() to return true; so that
cpufreq_init_cpu_capacity() can go ahead and profile CPU capacities
at boot time.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm64/kernel/topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 3b75d63..f2513a6 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -35,6 +35,11 @@ void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+bool arch_wants_init_cpu_capacity(void)
+{
+	return true;
+}
+
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
-- 
2.7.0
