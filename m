From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Tue, 20 Jun 2017 14:24:43 +0200
Subject: [PATCH] arm64: pass machine size to sparse
Message-ID: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using sparse on the arm64 tree we get many thousands of
warnings like 'constant ... is so big it is unsigned long long'
or 'shift too big (32) for type unsigned long'. This happens
because by default sparse considers the machine as 32bit and
defines the size of the types accordingly.

Fix this by passing the '-m64' flag to sparse so that
sparse can correctly define longs as being 64bit.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f839ecd91..15d6c1476 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -62,7 +62,7 @@ LD		+= -EL
 UTS_MACHINE	:= aarch64
 endif
 
-CHECKFLAGS	+= -D__aarch64__
+CHECKFLAGS	+= -D__aarch64__ -m64
 
 ifeq ($(CONFIG_ARM64_MODULE_CMODEL_LARGE), y)
 KBUILD_CFLAGS_MODULE	+= -mcmodel=large
-- 
2.13.0
