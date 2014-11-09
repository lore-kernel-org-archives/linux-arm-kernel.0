From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sun,  9 Nov 2014 23:10:23 +0800
Subject: [RFC Part4 v1 01/17] x86, irq: Normalize x86 irq_chip name
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415545839-28263-2-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some irq_chip names use underscore, others use hyphen. So normalize them.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index a220abbe842e..adc76eba59bd 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -179,7 +179,7 @@ dmar_msi_set_affinity(struct irq_data *data, const struct cpumask *mask,
 }
 
 static struct irq_chip dmar_msi_type = {
-	.name			= "DMAR_MSI",
+	.name			= "DMAR-MSI",
 	.irq_unmask		= dmar_msi_unmask,
 	.irq_mask		= dmar_msi_mask,
 	.irq_ack		= irq_chip_ack_parent,
@@ -310,7 +310,7 @@ static int hpet_msi_set_affinity(struct irq_data *data,
 }
 
 static struct irq_chip hpet_msi_type = {
-	.name = "HPET_MSI",
+	.name = "HPET-MSI",
 	.irq_unmask = hpet_msi_unmask,
 	.irq_mask = hpet_msi_mask,
 	.irq_ack = irq_chip_ack_parent,
-- 
1.7.10.4
