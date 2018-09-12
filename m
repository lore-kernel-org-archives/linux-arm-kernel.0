From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 12 Sep 2018 13:19:02 +0900
Subject: [PATCH] ARM: remove unnecessary KBUILD_SRC ifeq conditional
Message-ID: <1536725942-9206-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You can always prefix machine/plat header search paths with
$(srctree)/ because $(srctree) is '.' for in-tree building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: v4.19-rc3


 arch/arm/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f8..06ebff7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -264,13 +264,9 @@ platdirs := $(patsubst %,arch/arm/plat-%/,$(sort $(plat-y)))
 
 ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
 ifneq ($(CONFIG_ARM_SINGLE_ARMV7M),y)
-ifeq ($(KBUILD_SRC),)
-KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
-else
 KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
 endif
 endif
-endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-- 
2.7.4
