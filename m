From: damjan.marion@gmail.com (Damjan Marion)
Date: Fri, 24 Dec 2010 12:19:25 +0100
Subject: Bogus machine-type from bootloader
Message-ID: <BF43E57B-EE45-49B1-AE2A-96F8CBFD40FE@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


hi,

Is there any "proper" way if fixing bogus machine type sent by bootloader (ofcourse except fixing bootloader itself)?

I'm looking into code where author did following:


+++ a/arch/arm/boot/compressed/head-str9100.S	2009-01-20 04:26:26.000000000 +0100
@@ -0,0 +1,7 @@
+#include <asm/mach-types.h>
+
+		.section	".start", "ax"
+
+__str9100_start:
+		mov	r7, #(MACH_TYPE_STR9100 & 0xFF00)
+		orr	r7, r7, #(MACH_TYPE_STR9100 & 0x00FF)

I assume this is not something acceptable for having in official kernel source.


Damjan
