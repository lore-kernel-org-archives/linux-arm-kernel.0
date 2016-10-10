From: geoff@infradead.org (Geoff Levand)
Date: Mon, 10 Oct 2016 21:22:58 +0000
Subject: [PATCH 1/2] arm64: Cleanup kexec Makefile
In-Reply-To: <cover.1476134309.git.geoff@infradead.org>
References: <cover.1476134309.git.geoff@infradead.org>
Message-ID: <baa3da2fbfc708ee95cf96231ac92f98f8b9de29.1476134309.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put files in alphabetical order, reformat whitspace.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/arm64/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index 37414dc..d729df8 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -1,17 +1,18 @@
 
 arm64_FS2DT += kexec/fs2dt.c
-arm64_FS2DT_INCLUDE += -include $(srcdir)/kexec/arch/arm64/kexec-arm64.h \
-	-include $(srcdir)/kexec/arch/arm64/crashdump-arm64.h
+arm64_FS2DT_INCLUDE += \
+	-include $(srcdir)/kexec/arch/arm64/crashdump-arm64.h \
+	-include $(srcdir)/kexec/arch/arm64/kexec-arm64.h
 
 arm64_DT_OPS += kexec/dt-ops.c
 
 arm64_CPPFLAGS += -I $(srcdir)/kexec/
 
 arm64_KEXEC_SRCS += \
+	kexec/arch/arm64/crashdump-arm64.c \
 	kexec/arch/arm64/kexec-arm64.c \
-	kexec/arch/arm64/kexec-image-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
-	kexec/arch/arm64/crashdump-arm64.c
+	kexec/arch/arm64/kexec-image-arm64.c
 
 arm64_ARCH_REUSE_INITRD =
 arm64_ADD_SEGMENT =
@@ -19,9 +20,9 @@ arm64_VIRT_TO_PHYS =
 arm64_PHYS_TO_VIRT =
 
 dist += $(arm64_KEXEC_SRCS) \
-	kexec/arch/arm64/Makefile \
+	kexec/arch/arm64/crashdump-arm64.h \
 	kexec/arch/arm64/kexec-arm64.h \
-	kexec/arch/arm64/crashdump-arm64.h
+	kexec/arch/arm64/Makefile
 
 ifdef HAVE_LIBFDT
 
-- 
2.7.4
