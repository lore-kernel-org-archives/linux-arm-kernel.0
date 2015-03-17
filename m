From: lho@apm.com (Loc Ho)
Date: Tue, 17 Mar 2015 00:30:17 -0600
Subject: [PATCH v6 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <1426573821-1937-1-git-send-email-lho@apm.com>
References: <1426573821-1937-1-git-send-email-lho@apm.com>
Message-ID: <1426573821-1937-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an stub atomic_scrub and enable EDAC for arm64.

Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/Kconfig            |    1 +
 arch/arm64/include/asm/edac.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/edac.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e80cd74..d9c342a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select EDAC_SUPPORT
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm64/include/asm/edac.h b/arch/arm64/include/asm/edac.h
new file mode 100644
index 0000000..1cedba6
--- /dev/null
+++ b/arch/arm64/include/asm/edac.h
@@ -0,0 +1,31 @@
+/*
+ * ARM64 EDAC Header File
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef ASM_EDAC_H
+#define ASM_EDAC_H
+
+/*
+ * ECC atomic, DMA, SMP and interrupt safe scrub function.
+ * Implements the per arch atomic_scrub() that EDAC use for software
+ * ECC scrubbing.  It reads memory and then writes back the original
+ * value, allowing the hardware to detect and correct memory errors.
+ */
+static inline void atomic_scrub(void *va, u32 size)
+{
+	/* Stub function for now until an ARM64 HW has a way to test it. */
+}
+
+#endif
+
--
1.7.1
