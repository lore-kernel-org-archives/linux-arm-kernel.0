From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Jan 2011 12:38:24 +0200
Subject: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
Message-ID: <mailman.104.1294210300.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
so it's safe to drop the duplicated entry and simply
select HAVE_GENERIC_HARDIRQS. While at that, also
remove GENERIC_HARDIRQS_NO__DO_IRQ because it's also
defined under kernel/irq/Kconfig when
HAVE_GENERIC_HARDIRQS is selected.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c0..e6f0f8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_GENERIC_HARDIRQS
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
@@ -88,10 +89,6 @@ config MCA
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
-config GENERIC_HARDIRQS
-	bool
-	default y
-
 config STACKTRACE_SUPPORT
 	bool
 	default y
@@ -171,9 +168,6 @@ config FIQ
 config ARCH_MTD_XIP
 	bool
 
-config GENERIC_HARDIRQS_NO__DO_IRQ
-	def_bool y
-
 config ARM_L1_CACHE_SHIFT_6
 	bool
 	help
-- 
1.7.3.4.598.g85356


--TYecfFk8j8mZq+dy--
