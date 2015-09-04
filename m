From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 04 Sep 2015 16:29:51 +0300
Subject: [PATCH v4 TRIVIAL 1/2] ARM: Enable GICv2m on 32-bit virt machine
In-Reply-To: <cover.1441373056.git.p.fedin@samsung.com>
References: <cover.1441373056.git.p.fedin@samsung.com>
Message-ID: <6aa7150b2679f0ef434f89353b21235b06c1d164.1441373056.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msi.h is added because it is required by linux/msi.h if
CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined. It gets enabled by the following
KConfig dependency chain:
ARM_GIC_V2M => PCI_MSI_IRQ_DOMAIN => GENERIC_MSI_IRQ_DOMAIN

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/Kconfig            | 1 +
 arch/arm/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..1091025 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -815,6 +815,7 @@ config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V2M if PCI_MSI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 3c4596d..01806f5 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += param.h
 generic-y += parport.h
 generic-y += poll.h
-- 
2.4.4
