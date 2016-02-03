From: juri.lelli@arm.com (Juri Lelli)
Date: Wed,  3 Feb 2016 11:59:56 +0000
Subject: [PATCH v3 3/6] arm: Enable dynamic CPU capacity initialization
In-Reply-To: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Message-ID: <1454500799-18451-4-git-send-email-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define arch_wants_init_cpu_capacity() to return true; so that
cpufreq_init_cpu_capacity() can go ahead and profile CPU capacities
at boot time.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm/kernel/topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index c9c87a5..7d7fc2c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -52,6 +52,11 @@ void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+bool arch_wants_init_cpu_capacity(void)
+{
+	return true;
+}
+
 #ifdef CONFIG_OF
 struct cpu_efficiency {
 	const char *compatible;
-- 
2.7.0
