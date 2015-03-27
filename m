From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 Mar 2015 20:43:35 +0900
Subject: [PATCH 1/4] kbuild: use relative path to include Makefile
In-Reply-To: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
References: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1427456618-23830-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "MAKEFLAGS += --include-dir=$(srctree)" line in the top Makefile
allows us to do this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/Makefile    | 2 +-
 arch/ia64/kernel/Makefile | 2 +-
 scripts/Makefile.dtbinst  | 2 +-
 scripts/Makefile.fwinst   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index ec2f806..9eca7ae 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -12,7 +12,7 @@
 #
 
 ifneq ($(MACHINE),)
-include $(srctree)/$(MACHINE)/Makefile.boot
+include $(MACHINE)/Makefile.boot
 endif
 
 # Note: the following conditions must always be true:
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 20678a9..47e8aff 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -51,7 +51,7 @@ obj-$(CONFIG_BINFMT_ELF)	+= elfcore.o
 CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
 
 # The gate DSO image is built using a special linker script.
-include $(srctree)/arch/ia64/kernel/Makefile.gate
+include arch/ia64/kernel/Makefile.gate
 # tell compiled for native
 CPPFLAGS_gate.lds += -D__IA64_GATE_PARAVIRTUALIZED_NATIVE
 
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 909ed7a..7cbff16 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -18,7 +18,7 @@ export dtbinst-root ?= $(obj)
 
 include include/config/auto.conf
 include scripts/Kbuild.include
-include $(srctree)/$(obj)/Makefile
+include $(obj)/Makefile
 
 PHONY += __dtbs_install_prep
 __dtbs_install_prep:
diff --git a/scripts/Makefile.fwinst b/scripts/Makefile.fwinst
index 5b698ad..baf5eae 100644
--- a/scripts/Makefile.fwinst
+++ b/scripts/Makefile.fwinst
@@ -13,7 +13,7 @@ src := $(obj)
 -include $(objtree)/.config
 
 include scripts/Kbuild.include
-include $(srctree)/$(obj)/Makefile
+include $(obj)/Makefile
 
 include scripts/Makefile.host
 
-- 
1.9.1
