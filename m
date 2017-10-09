From: caoj.fnst@cn.fujitsu.com (Cao jin)
Date: Mon, 9 Oct 2017 15:11:45 +0800
Subject: [PATCH 1/3] arm/kbuild: replace {C, LD}FLAGS_MODULE with KBUILD_{C,
 LD}FLAGS_MODULE
Message-ID: <1507533107-2069-1-git-send-email-caoj.fnst@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As kbuild document & commit 6588169d51 says: KBUILD_{C,LD}FLAGS_MODULE are
used to add arch-specific options for $(CC) and $(LD). From commandline,
{C,LD}FLAGS_MODULE shall be used.
Doesn't have any functional change, but just follow kbuild rules.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
CC: Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1a..a945b1f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,11 +16,11 @@ LDFLAGS		:=
 LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
-LDFLAGS_MODULE	+= --be8
+KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
-LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
+KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
 endif
 
 GZFLAGS		:=-9
@@ -120,7 +120,7 @@ CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
-CFLAGS_MODULE	+=-fno-optimize-sibling-calls
+KBUILD_CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 else
 CFLAGS_ISA	:=$(call cc-option,-marm,)
-- 
2.1.0
