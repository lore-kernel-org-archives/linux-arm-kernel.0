From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:08 +0100
Subject: [PATCH 02/14] arm64: big-endian: add big-endian support to top-level
 arch Makefile
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-3-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

This patch adds big-endian support to the AArch64 top-level Makefile.
This currently just passes the relevant flags to the toolchain and is
predicated on a Kconfig option that will be introduced later on.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d90cf79..2fceb71 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -20,9 +20,15 @@ LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 KBUILD_DEFCONFIG := defconfig
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only
+ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
+KBUILD_CPPFLAGS	+= -mbig-endian
+AS		+= -EB
+LD		+= -EB
+else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+endif
 
 comma = ,
 
-- 
1.7.9.5
