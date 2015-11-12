From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Nov 2015 20:04:42 +0800
Subject: [PATCH 1/3] arm64: smp: make of_parse_and_init_cpus static
In-Reply-To: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
References: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
Message-ID: <1447329884-1644-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_parse_and_init_cpus is only called from within smp.c, so it can be
declared static.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2bbdc0e..b1adc51 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -473,7 +473,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
  * cpu logical map array containing MPIDR values related to logical
  * cpus. Assumes that cpu_logical_map(0) has already been initialized.
  */
-void __init of_parse_and_init_cpus(void)
+static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn = NULL;
 
-- 
2.6.2
