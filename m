From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 25 Sep 2013 12:11:33 +0200
Subject: [PATCH] arm: mach-integrator: Add stub for pci_v3_early_init() for
 !CONFIG_PCI
Message-ID: <1380103893-7119-1-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a compile error where CONFIG_PCI is disabled:

  LD      init/built-in.o
arch/arm/mach-integrator/built-in.o: In function `ap_map_io':
integrator_cp.c:(.init.text+0x570): undefined reference to `pci_v3_early_init'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

Cc: stable at vger.kernel.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joerg Roedel <joro@8bytes.org>
---
 arch/arm/mach-integrator/pci_v3.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-integrator/pci_v3.h b/arch/arm/mach-integrator/pci_v3.h
index 755fd29..06a9e2e 100644
--- a/arch/arm/mach-integrator/pci_v3.h
+++ b/arch/arm/mach-integrator/pci_v3.h
@@ -1,2 +1,9 @@
 /* Simple oneliner include to the PCIv3 early init */
+#ifdef CONFIG_PCI
 extern int pci_v3_early_init(void);
+#else
+static inline int pci_v3_early_init(void)
+{
+	return 0;
+}
+#endif
-- 
1.7.9.5
