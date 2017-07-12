From: rrichter@cavium.com (Robert Richter)
Date: Wed, 12 Jul 2017 15:25:09 +0200
Subject: [PATCH] irqchip/gic-v3-its: Remove ACPICA version check for ACPI NUMA
Message-ID: <20170712132509.11281-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The version check was added due to dependency to

 a618c7f89a02 ACPICA: Add support for new SRAT subtable

Now, that this code is in the kernel, remove the check. This is esp.
useful to enable backports.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index bb33ba1837a9..745c5772e99b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1858,7 +1858,7 @@ static int __init its_of_probe(struct device_node *node)
 
 #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
 
-#if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >= 0x20170531)
+#ifdef CONFIG_ACPI_NUMA
 struct its_srat_map {
 	/* numa node id */
 	u32	numa_node;
-- 
2.11.0
