From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:17 +0900
Subject: [PATCH 6/6] ARM: decompressor: rename suffix_y to compress-y
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456126277-14633-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "$(suffix_y)" no longer appears in the file names, but it just
specifies the method of the file compression.  The "compress-y" sounds
more suitable.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 3243f09..5018bfa 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -66,11 +66,11 @@ endif
 
 CPPFLAGS_vmlinux.lds := -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
 
-suffix_$(CONFIG_KERNEL_GZIP) = gzip
-suffix_$(CONFIG_KERNEL_LZO)  = lzo
-suffix_$(CONFIG_KERNEL_LZMA) = lzma
-suffix_$(CONFIG_KERNEL_XZ)   = xzkern
-suffix_$(CONFIG_KERNEL_LZ4)  = lz4
+compress-$(CONFIG_KERNEL_GZIP) = gzip
+compress-$(CONFIG_KERNEL_LZO)  = lzo
+compress-$(CONFIG_KERNEL_LZMA) = lzma
+compress-$(CONFIG_KERNEL_XZ)   = xzkern
+compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
 # Borrowed libfdt files for the ATAG compatibility mode
 
@@ -183,7 +183,7 @@ $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
 	@$(check_for_bad_syms)
 
 $(obj)/piggy_data: $(obj)/../Image FORCE
-	$(call if_changed,$(suffix_y))
+	$(call if_changed,$(compress-y))
 
 $(obj)/piggy.o: $(obj)/piggy_data
 
-- 
1.9.1
