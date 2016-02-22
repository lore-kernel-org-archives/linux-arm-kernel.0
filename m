From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:13 +0900
Subject: [PATCH 2/6] ARM: decompressor: drop more unneeded assignments to
 "targets"
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456126277-14633-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The objects "font.o" and "misc.o" are contained in $(OBJS), and it
is already added to the "targets".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 7090ad3..476ef00 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -92,7 +92,7 @@ endif
 targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
 		 lib1funcs.o ashldi3.o bswapsdi2.o \
-		 font.o head.o misc.o $(OBJS)
+		 head.o $(OBJS)
 
 # Make sure files are removed during clean
 extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
-- 
1.9.1
