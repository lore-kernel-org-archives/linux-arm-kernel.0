From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue,  9 Nov 2010 11:06:12 +0200
Subject: [PATCH 3/4] ARM: add CONFIG_CRASH_DUMP to Kconfig
In-Reply-To: <cover.1289292124.git.mika.westerberg@iki.fi>
References: <cover.1289292124.git.mika.westerberg@iki.fi>
Message-ID: <3cae99ef4ab792c1e7c632dcfa6a2c16e5d2a190.1289292124.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Add CONFIG_CRASH_DUMP configuration option which is used by dump
capture kernels.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/Kconfig |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..78774d9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1650,6 +1650,19 @@ config ATAGS_PROC
 	  Should the atags used to boot the kernel be exported in an "atags"
 	  file in procfs. Useful with kexec.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec. The crash dump kernel must be compiled to a
+	  memory address not used by the main kernel
+
+	  For more details see Documentation/kdump/kdump.txt
+
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address"
 	depends on !ZBOOT_ROM && !ARCH_U300
-- 
1.7.2.3
