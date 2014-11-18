From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Nov 2014 18:53:07 +0000
Subject: [PATCH v2 12/13] irqchip: GICv3: ITS: enable compilation of the ITS
 driver
In-Reply-To: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
References: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416336788-22634-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get the show on the road...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig       | 1 +
 drivers/irqchip/Kconfig  | 4 ++++
 drivers/irqchip/Makefile | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d..242948d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,7 @@ config ARM64
 	select ARM_GIC
 	select AUDIT_ARCH_COMPAT_GENERIC
 	select ARM_GIC_V3
+	select ARM_GIC_V3_ITS if PCI_MSI
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4631685..aaa260b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -16,6 +16,10 @@ config ARM_GIC_V3
 	select MULTI_IRQ_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 
+config ARM_GIC_V3_ITS
+	bool
+	select PCI_MSI_IRQ_DOMAIN
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 173bb5f..ec3621d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
-- 
2.1.3
