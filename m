From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 15:19:19 +0800
Subject: [PATCH 3/3] arm64: kernel: declare cpu_ops __read_mostly
In-Reply-To: <1470813559-2917-1-git-send-email-jszhang@marvell.com>
References: <1470813559-2917-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470813559-2917-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_ops is initialized once by cpu_read_ops(), and thereafter is mostly
read in hot path, such as arm_cpuidle_suspend().

The fact that it is mostly read and not written to makes it candidates
for __read_mostly declarations.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/cpu_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index c7cfb8f..c1e4802 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -28,7 +28,7 @@ extern const struct cpu_operations smp_spin_table_ops;
 extern const struct cpu_operations acpi_parking_protocol_ops;
 extern const struct cpu_operations cpu_psci_ops;
 
-const struct cpu_operations *cpu_ops[NR_CPUS];
+const struct cpu_operations *cpu_ops[NR_CPUS] __read_mostly;
 
 static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
 	&smp_spin_table_ops,
-- 
2.8.1
