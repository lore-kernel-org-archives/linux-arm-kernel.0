From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  7 May 2012 11:10:49 +0800
Subject: [PATCH 2/2] ARM: mmp: add io head file
In-Reply-To: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336360249-29963-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need IO_SPACE_LIMIT definition. Otherwise, we can't register max8925
PMIC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/Kconfig                    |    1 +
 arch/arm/mach-mmp/include/mach/io.h |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36586dba..d503539 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -636,6 +636,7 @@ config ARCH_MMP
 	select PLAT_PXA
 	select SPARSE_IRQ
 	select GENERIC_ALLOCATOR
+	select NEED_MACH_IO_H
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
diff --git a/arch/arm/mach-mmp/include/mach/io.h b/arch/arm/mach-mmp/include/mach/io.h
new file mode 100644
index 0000000..ad25061
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/io.h
@@ -0,0 +1,13 @@
+/*
+ * arch/arm/mach-mmp/include/mach/io.h
+ *
+ */
+#ifndef __ARCH_MMP_IO_H
+#define __ARCH_MMP_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+#define __io(a)		((a) & IO_SPACE_LIMIT)
+
+#endif
+
-- 
1.7.5.4
