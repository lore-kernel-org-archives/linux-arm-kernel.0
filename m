From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  1 May 2018 14:31:20 +0200
Subject: [PATCH v8 01/12] ARM: Allow this header to be included by assembly
 files
In-Reply-To: <20180501123131.7738-1-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
Message-ID: <20180501123131.7738-2-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Berger <opendmb@gmail.com>

The constants defined in this file are equally useful in assembly and C
source files. The arm64 architecture version of this file allows
inclusion in both assembly and C source files, so this this commit adds
that capability to the arm architecture version so that the constants
don't need to be defined in multiple places.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/include/asm/cputype.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..e7632f536633 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -2,9 +2,6 @@
 #ifndef __ASM_ARM_CPUTYPE_H
 #define __ASM_ARM_CPUTYPE_H
 
-#include <linux/stringify.h>
-#include <linux/kernel.h>
-
 #define CPUID_ID	0
 #define CPUID_CACHETYPE	1
 #define CPUID_TCM	2
@@ -98,6 +95,11 @@
 /* Qualcomm implemented cores */
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
+#ifndef __ASSEMBLY__
+
+#include <linux/stringify.h>
+#include <linux/kernel.h>
+
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
@@ -326,4 +328,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 #define cpuid_feature_extract(reg, field) \
 	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
 
+#endif /* __ASSEMBLY__ */
+
 #endif
-- 
2.11.0
