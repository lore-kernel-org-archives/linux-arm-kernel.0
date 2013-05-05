From: alonid@stratoscale.com (Dan Aloni)
Date: Sun,  5 May 2013 11:24:13 +0300
Subject: [PATCH] Move the EM_ARM and EM_AARCH64 definitions to
 uapi/linux/elf-em.h
In-Reply-To: <20130502132756.GD20730@arm.com>
References: <20130502132756.GD20730@arm.com>
Message-ID: <1367742253-22294-1-git-send-email-alonid@stratoscale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dan Aloni <alonid@stratoscale.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/elf.h   |    2 --
 arch/arm64/include/asm/elf.h |    3 ---
 include/uapi/linux/elf-em.h  |    2 ++
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 38050b1..e110a67 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -19,8 +19,6 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 typedef struct user_fp elf_fpregset_t;
 
-#define EM_ARM	40
-
 #define EF_ARM_EABI_MASK	0xff000000
 #define EF_ARM_EABI_UNKNOWN	0x00000000
 #define EF_ARM_EABI_VER1	0x01000000
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index fe32c0e..e7fa87f 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -33,8 +33,6 @@ typedef unsigned long elf_greg_t;
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 typedef struct user_fpsimd_state elf_fpregset_t;
 
-#define EM_AARCH64		183
-
 /*
  * AArch64 static relocation types.
  */
@@ -151,7 +149,6 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #define arch_randomize_brk arch_randomize_brk
 
 #ifdef CONFIG_COMPAT
-#define EM_ARM				40
 #define COMPAT_ELF_PLATFORM		("v8l")
 
 #define COMPAT_ELF_ET_DYN_BASE		(randomize_et_dyn(2 * TASK_SIZE_32 / 3))
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 8e2b7ba..59c17a2 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -22,6 +22,7 @@
 #define EM_PPC		20	/* PowerPC */
 #define EM_PPC64	21	 /* PowerPC64 */
 #define EM_SPU		23	/* Cell BE SPU */
+#define EM_ARM		40	/* ARM 32 bit */
 #define EM_SH		42	/* SuperH */
 #define EM_SPARCV9	43	/* SPARC v9 64-bit */
 #define EM_IA_64	50	/* HP/Intel IA-64 */
@@ -34,6 +35,7 @@
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
 #define EM_AVR32	0x18ad	/* Atmel AVR32 */
 
-- 
1.7.10.4
