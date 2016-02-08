From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  8 Feb 2016 14:04:58 +0900
Subject: [PATCH 1/2] ARM: remove bzImage target
Message-ID: <1454907899-32101-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bzImage has been just an alias for zImage for more than a decade.
It would not hurt to delete it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 46fb1ca..d6d453f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -312,13 +312,10 @@ boot := arch/arm/boot
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/generated/mach-types.h
 
-# Convert bzImage to zImage
-bzImage: zImage
-
 BOOT_TARGETS	= zImage Image xipImage bootpImage uImage
 INSTALL_TARGETS	= zinstall uinstall install
 
-PHONY += bzImage $(BOOT_TARGETS) $(INSTALL_TARGETS)
+PHONY += $(BOOT_TARGETS) $(INSTALL_TARGETS)
 
 bootpImage uImage: zImage
 zImage: Image
-- 
1.9.1
