From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:15 +0900
Subject: [PATCH 4/6] ARM: decompressor: drop redundant FORCE in Makefile
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456126277-14633-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The object "piggy.$(suffix_y).o" is created from "piggy.$(suffix).S"
by the following pattern rule defined in scripts/Makefile.build:

  $(obj)/%.o: $(src)/%.S FORCE
          $(call if_changed_dep,as_o_S)

FORCE is already added to the prerequisite of the object there.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index f9e8e68..903b953 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -187,7 +187,7 @@ $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
 $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
 	$(call if_changed,$(suffix_y))
 
-$(obj)/piggy.$(suffix_y).o:  $(obj)/piggy.$(suffix_y) FORCE
+$(obj)/piggy.$(suffix_y).o:  $(obj)/piggy.$(suffix_y)
 
 CFLAGS_font.o := -Dstatic=
 
-- 
1.9.1
