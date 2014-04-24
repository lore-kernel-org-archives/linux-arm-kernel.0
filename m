From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 12:24:03 +0200
Subject: [PATCH 1/4] ARM: compressed/head.S: remove s3c24xx special case
In-Reply-To: <1544889.hRy2JpKRQe@phil>
References: <1544889.hRy2JpKRQe@phil>
Message-ID: <3212063.TCv3gzNlr5@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

addruart from the generic debug macro is doing exactly the same using
the common lowlevel uart definition, so there is no cause for this
special casing for s3c24xx.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/compressed/head.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 066b034..3a8b32d 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -60,11 +60,6 @@
 		add	\rb, \rb, #0x00010000	@ Ser1
 #endif
 		.endm
-#elif defined(CONFIG_ARCH_S3C24XX)
-		.macro loadsp, rb, tmp
-		mov	\rb, #0x50000000
-		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
-		.endm
 #else
 		.macro	loadsp,	rb, tmp
 		addruart \rb, \tmp
-- 
1.9.0
