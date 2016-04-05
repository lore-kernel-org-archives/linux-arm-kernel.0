From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  5 Apr 2016 11:08:26 +0900
Subject: [PATCH] ARM: specify install, zinstall, and uinstall as PHONY targets
Message-ID: <1459822106-4414-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Obviously, these are PHONY targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 4.6-rc1

 arch/arm/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 48fab15..446705a 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -88,7 +88,7 @@ $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
 	@$(kecho) '  Kernel: $@ is ready'
 
-PHONY += initrd
+PHONY += initrd install zinstall uinstall
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
 	(echo This machine does not support INITRD; exit -1)
-- 
1.9.1
