From: haokexin@gmail.com (Kevin Hao)
Date: Wed, 14 Jan 2015 18:38:54 +0800
Subject: [PATCH] arm64: kill off the libgcc dependency
Message-ID: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 doesn't depend on the libgcc to build the vmlinux image.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/arm64/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1c43cec971b5..a20c28348be4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -15,8 +15,6 @@ CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 GZFLAGS		:=-9
 
-LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
-
 KBUILD_DEFCONFIG := defconfig
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only
@@ -50,7 +48,6 @@ core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
 core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
-libs-y		+= $(LIBGCC)
 libs-$(CONFIG_EFI_STUB) += drivers/firmware/efi/libstub/
 
 # Default target when executing plain make
-- 
1.9.3
