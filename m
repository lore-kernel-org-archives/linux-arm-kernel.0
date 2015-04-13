From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:19 +0200
Subject: [PATCH v4 09/24] arm64:ilp32: use non-compat syscall names for ILP32
 as for LP64
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <e1493414f189a677c661659fb8d260e85ece0062.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Define __ARCH_WANT_64BIT_SYSCALLS for ILP32, so we (can) use the 64bit
syscall names for ILP32.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/uapi/asm/unistd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 1caadc2..067eab0 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2014 Cavium Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,4 +14,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+/* For ILP32 AARCH64, we want to use the non compat names. */
+#if defined(__aarch64__) && defined(__ILP32__)
+#define __SYSCALL_NONCOMPAT
+#endif
+
 #include <asm-generic/unistd.h>
-- 
1.9.1
