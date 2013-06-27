From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 27 Jun 2013 13:12:20 -0700
Subject: [PATCH] ARM: zImage: fix path to fonts which moved to lib/fonts
Message-ID: <1372363940-13023-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 1affee67 (lib: Move fonts from drivers/video/console/ to lib/fonts/)
moved fonts from drivers/video/console/ to lib/fonts, but the ARM zImage
build still references the old location.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Found due to build failures on ARM in next-20130627.

Rather than go through the ARM tree, this should probably be included
with the original series from Geert.

 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 13499a8..7ac1610 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -27,7 +27,7 @@ OBJS	+= misc.o decompress.o
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 endif
-FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
+FONTC	= $(srctree)/lib/fonts/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
 OBJS		+= string.o
-- 
1.8.3
