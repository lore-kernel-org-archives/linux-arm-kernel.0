From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Apr 2015 08:14:12 -0500
Subject: [PATCH 1/2] libfdt: add fdt type definitions
Message-ID: <1430399653-30269-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for libfdt/dtc update, add the new fdt specific types.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
---
 arch/arm/boot/compressed/libfdt_env.h | 4 ++++
 arch/powerpc/boot/libfdt_env.h        | 4 ++++
 arch/powerpc/boot/of.h                | 2 ++
 include/linux/libfdt_env.h            | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index 1f4e718..17ae0f3 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -5,6 +5,10 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
+typedef __be16 fdt16_t;
+typedef __be32 fdt32_t;
+typedef __be64 fdt64_t;
+
 #define fdt16_to_cpu(x)		be16_to_cpu(x)
 #define cpu_to_fdt16(x)		cpu_to_be16(x)
 #define fdt32_to_cpu(x)		be32_to_cpu(x)
diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index 8dcd744..7e3789e 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -10,6 +10,10 @@ typedef u32 uint32_t;
 typedef u64 uint64_t;
 typedef unsigned long uintptr_t;
 
+typedef __be16 fdt16_t;
+typedef __be32 fdt32_t;
+typedef __be64 fdt64_t;
+
 #define fdt16_to_cpu(x)		be16_to_cpu(x)
 #define cpu_to_fdt16(x)		cpu_to_be16(x)
 #define fdt32_to_cpu(x)		be32_to_cpu(x)
diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index 5603320..53f8f27 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -21,7 +21,9 @@ int of_setprop(const void *phandle, const char *name, const void *buf,
 /* Console functions */
 void of_console_init(void);
 
+typedef u16			__be16;
 typedef u32			__be32;
+typedef u64			__be64;
 
 #ifdef __LITTLE_ENDIAN__
 #define cpu_to_be16(x) swab16(x)
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index 01508c7..2a663c6 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -5,6 +5,10 @@
 
 #include <asm/byteorder.h>
 
+typedef __be16 fdt16_t;
+typedef __be32 fdt32_t;
+typedef __be64 fdt64_t;
+
 #define fdt32_to_cpu(x) be32_to_cpu(x)
 #define cpu_to_fdt32(x) cpu_to_be32(x)
 #define fdt64_to_cpu(x) be64_to_cpu(x)
-- 
2.1.0
