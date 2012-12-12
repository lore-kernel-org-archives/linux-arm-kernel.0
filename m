From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Dec 2012 21:01:17 +0800
Subject: [PATCH] ARM: decompress: remove unused ARCH_HAS_DECOMP_WDOG
Message-ID: <1355317277-32192-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_HAS_DECOMP_WDOG is only used in lib/inflate.c which is not
included in arch/arm/boot/compressed/decompress.c now.  That said,
ARCH_HAS_DECOMP_WDOG is not used at all.  Let's remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Russell,

If you're fine with patch, I will send a follow-up patch to remove all
those arch_decomp_wdog() from platform uncompress.h which does nothing
at all.

Shawn

 arch/arm/boot/compressed/decompress.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 9deb56a..24b0475 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -13,8 +13,6 @@ extern void error(char *);
 #define STATIC static
 #define STATIC_RW_DATA	/* non-static please */
 
-#define ARCH_HAS_DECOMP_WDOG
-
 /* Diagnostic functions */
 #ifdef DEBUG
 #  define Assert(cond,msg) {if(!(cond)) error(msg);}
-- 
1.7.9.5
