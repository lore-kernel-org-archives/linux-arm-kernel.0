From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:14 +0900
Subject: [PATCH 3/6] ARM: decompressor: use clean-files instead of extra-y to
 clean files
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456126277-14633-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code works fine here, but it is tricky to use "extra-y" for
specifying files to be removed during "make clean".  Kbuild provides
"clean-files" for this purpose.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 476ef00..f9e8e68 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -94,8 +94,7 @@ targets       := vmlinux vmlinux.lds \
 		 lib1funcs.o ashldi3.o bswapsdi2.o \
 		 head.o $(OBJS)
 
-# Make sure files are removed during clean
-extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
+clean-files += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
 		 lib1funcs.S ashldi3.S bswapsdi2.S $(libfdt) $(libfdt_hdrs) \
 		 hyp-stub.S
 
-- 
1.9.1
