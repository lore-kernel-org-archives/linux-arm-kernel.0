From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:06 +0300
Subject: [PATCH v5 09/23] arm64:ilp32: use non-compat syscall names for ILP32
 as for LP64
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-10-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Define __ARCH_WANT_64BIT_SYSCALLS for ILP32, so we (can) use the 64bit
syscall names for ILP32.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 1caadc2..067eab0 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Cavium Inc.
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
2.1.4
