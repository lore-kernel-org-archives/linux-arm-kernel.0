From: robherring2@gmail.com (Rob Herring)
Date: Sat,  4 Aug 2012 20:23:57 -0500
Subject: [PATCH v2 2/5] ARM: add strstr declaration for decompressors
In-Reply-To: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
Message-ID: <1344129840-16447-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With the generic unaligned.h, more kernel headers get pulled in including
dynamic_debug.h which needs strstr. As it is not really used, we only need
a declaration here.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/compressed/decompress.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index f41b38c..9deb56a 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -32,6 +32,9 @@ extern void error(char *);
 #  define Tracecv(c,x)
 #endif
 
+/* Not needed, but used in some headers pulled in by decompressors */
+extern char * strstr(const char * s1, const char *s2);
+
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
 #endif
-- 
1.7.9.5
