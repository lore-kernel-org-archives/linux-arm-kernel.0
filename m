From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 22:12:43 +0800
Subject: [PATCH 1/3] ARM: decompress: remove unused ARCH_HAS_DECOMP_WDOG
In-Reply-To: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1357827165-9320-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_HAS_DECOMP_WDOG is only used in lib/inflate.c which is not
included in arch/arm/boot/compressed/decompress.c now.  That said,
ARCH_HAS_DECOMP_WDOG is not used at all.  Let's remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
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
