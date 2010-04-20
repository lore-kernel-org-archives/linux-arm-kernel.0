From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 11:50:54 +0300
Subject: [PATCH 8/8] arm: kdump: add CONFIG_CRASH_DUMP Kconfig option
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <7bb5e29aa8da6104c0f24c5fb45c93b860d0897f.1271752135.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_CRASH_DUMP configuration option which is used by dump capture
kernels. Dump capture kernel must be loaded into different physical address
than the primary kernel. This means that PHYS_OFFSET must be different and
it also should match the 'crashkernel=size at start' value passed to primary
kernel command line.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..b8c37dc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1466,6 +1466,18 @@ config ATAGS_PROC
 	  Should the atags used to boot the kernel be exported in an "atags"
 	  file in procfs. Useful with kexec.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Build a kernel suitable for use as kdump capture kernel. This should
+	  be set only on dump capture kernels. Note that dump capture kernel
+	  must be loaded into different physical address than the primary kernel
+	  (e.g set PHYS_OFFSET and related mach/Makefile.boot parameters
+	  to match value given in 'crashkernel=size at start').
+
+	  For more details see Documentation/kdump/kdump.txt
+
 endmenu
 
 menu "CPU Power Management"
-- 
1.5.6.5
