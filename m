From: kim.phillips@freescale.com (Kim Phillips)
Date: Tue, 26 Feb 2013 19:36:13 -0600
Subject: [PATCH 1/3] libfdt: add fdt type definitions in libfdt_env.h
Message-ID: <1361928975-29395-1-git-send-email-kim.phillips@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in preparation for the forthcoming dtc update which adds fdt specific
types: fdt{16,32,64}_t.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/arm/boot/compressed/libfdt_env.h | 4 ++++
 include/linux/libfdt_env.h            | 6 ++++++
 2 files changed, 10 insertions(+)

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
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index 01508c7..da98097 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -5,6 +5,12 @@
 
 #include <asm/byteorder.h>
 
+typedef __be16 fdt16_t;
+typedef __be32 fdt32_t;
+typedef __be64 fdt64_t;
+
+#define fdt16_to_cpu(x) be16_to_cpu(x)
+#define cpu_to_fdt16(x) cpu_to_be16(x)
 #define fdt32_to_cpu(x) be32_to_cpu(x)
 #define cpu_to_fdt32(x) cpu_to_be32(x)
 #define fdt64_to_cpu(x) be64_to_cpu(x)
-- 
1.8.1.4
