From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Sep 2018 15:07:37 +0200
Subject: [PATCH] arm64: remove unused asm/compiler.h header file
Message-ID: <20180927130737.31301-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 does not define CONFIG_HAVE_ARCH_COMPILER_H, nor does it keep
anything useful in its copy of asm/compiler.h, so let's remove it
before anybody starts using it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/compiler.h | 30 ------------------------------
 arch/arm64/include/asm/sysreg.h   |  1 -
 arch/arm64/include/asm/uaccess.h  |  1 -
 arch/arm64/kernel/psci.c          |  1 -
 4 files changed, 33 deletions(-)
 delete mode 100644 arch/arm64/include/asm/compiler.h

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
deleted file mode 100644
index ee35fd0f2236..000000000000
--- a/arch/arm64/include/asm/compiler.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Based on arch/arm/include/asm/compiler.h
- *
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_COMPILER_H
-#define __ASM_COMPILER_H
-
-/*
- * This is used to ensure the compiler did actually allocate the register we
- * asked it for some inline assembly sequences.  Apparently we can't trust the
- * compiler from one version to another so a bit of paranoia won't hurt.  This
- * string is meant to be concatenated with the inline asm string and will
- * cause compilation to stop on mismatch.  (for details, see gcc PR 15089)
- */
-#define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
-
-#endif	/* __ASM_COMPILER_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c1470931b897..6d307212bf7c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,7 +20,6 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
-#include <asm/compiler.h>
 #include <linux/stringify.h>
 
 /*
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2..07c34087bd5e 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -32,7 +32,6 @@
 #include <asm/cpufeature.h>
 #include <asm/ptrace.h>
 #include <asm/memory.h>
-#include <asm/compiler.h>
 #include <asm/extable.h>
 
 #define get_ds()	(KERNEL_DS)
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index e8edbf13302a..8cdaf25e99cd 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -24,7 +24,6 @@
 
 #include <uapi/linux/psci.h>
 
-#include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
 #include <asm/smp_plat.h>
-- 
2.18.0
