From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Jul 2011 22:32:13 -0500
Subject: [RFC PATCH 2/3] ARM: add a default mach/uncompress.h header
In-Reply-To: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
Message-ID: <1311823934-29553-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add default empty functions to allow platforms to use a default
uncompress.h header. This helps enable support of multi-platform kernels,
you lose serial output in the decompressor. Only a couple of platforms
need arch_decomp_setup and/or arch_decomp_wdog.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/mach/uncompress.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/mach/uncompress.h

diff --git a/arch/arm/include/mach/uncompress.h b/arch/arm/include/mach/uncompress.h
new file mode 100644
index 0000000..9277c85
--- /dev/null
+++ b/arch/arm/include/mach/uncompress.h
@@ -0,0 +1,9 @@
+#ifndef __MACH_UNCOMPRESS_H
+#define __MACH_UNCOMPRESS_H
+
+static inline void putc(char) {}
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
+static inline void arch_decomp_wdog(void) {}
+
+#endif
-- 
1.7.4.1
