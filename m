From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:19 -0500
Subject: [RFC PATCH 05/10] mx51: change MX51 specific config from ARCH_MX5 to
	ARCH_MX51
Message-ID: <1271446524-26450-6-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
 arch/arm/plat-mxc/include/mach/irqs.h        |    2 +-
 arch/arm/plat-mxc/include/mach/memory.h      |    2 +-
 arch/arm/plat-mxc/include/mach/mxc.h         |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 0b6e11e..a99eedf 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -45,7 +45,7 @@
 #define UART_VADDR	AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
 #endif
 
-#ifdef CONFIG_ARCH_MX5
+#ifdef CONFIG_ARCH_MX51
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 86781f7..769a137 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -29,7 +29,7 @@
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MX25
 #define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX5
+#elif defined CONFIG_ARCH_MX51
 #define MXC_GPIO_IRQS		(32 * 4)
 #elif defined CONFIG_ARCH_MXC91231
 #define MXC_GPIO_IRQS		(32 * 4)
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index c4b40c3..05e5b75 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -32,7 +32,7 @@
 #  define PHYS_OFFSET		MX3x_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MXC91231
 #  define PHYS_OFFSET		MXC91231_PHYS_OFFSET
-# elif defined CONFIG_ARCH_MX5
+# elif defined CONFIG_ARCH_MX51
 #  define PHYS_OFFSET		MX51_PHYS_OFFSET
 # endif
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index a790bf2..ec85f14 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -109,7 +109,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx35()		(0)
 #endif
 
-#ifdef CONFIG_ARCH_MX5
+#ifdef CONFIG_ARCH_MX51
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
-- 
1.6.0.4
