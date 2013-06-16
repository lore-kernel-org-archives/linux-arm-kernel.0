From: kyle@redhat.com (Kyle McMartin)
Date: Sun, 16 Jun 2013 15:32:44 -0400
Subject: [PATCH] arm64/Makefile: provide vdso_install target
Message-ID: <20130616193243.GC8939@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a vdso_install target in the arm64 Makefile, as other architectures
with a vdso do.

Signed-off-by: Kyle McMartin <kyle@redhat.com>

--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,6 +60,10 @@ zinstall install: vmlinux
 dtbs: scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts dtbs
 
+PHONY += vdso_install
+vdso_install:
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
+
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
