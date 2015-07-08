From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Jul 2015 18:13:34 +0800
Subject: [PATCH 1/4] arm: psci: rename psci_smp.c to psci.c
In-Reply-To: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
References: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436350417-6712-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to enable PSCI feature on UP kernels. The renaming in this
patch prepares for next commit to enable PSCI for UP systems.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/Makefile               | 2 +-
 arch/arm/kernel/{psci_smp.c => psci.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/kernel/{psci_smp.c => psci.c} (100%)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 3b995f5..c57b2c0 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -90,7 +90,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-y				+= psci-call.o
-obj-$(CONFIG_SMP)		+= psci_smp.o
+obj-$(CONFIG_SMP)		+= psci.o
 endif
 
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci.c
similarity index 100%
rename from arch/arm/kernel/psci_smp.c
rename to arch/arm/kernel/psci.c
-- 
2.1.4
