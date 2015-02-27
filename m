From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Fri, 27 Feb 2015 16:00:36 +0100
Subject: [PATCH v2 1/9] x86,
 pci: Clean up comment about buggy MMIO config space access for AMD
 Fam10h CPUs.
In-Reply-To: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1425049244-19331-2-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- fix typo
- improve explanation
- add reference to the related document

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/include/asm/pci_x86.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 164e3f8..eddf8f0 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -154,10 +154,13 @@ extern struct list_head pci_mmcfg_list;
 
 /*
  * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
- * on their northbrige except through the * %eax register. As such, you MUST
- * NOT use normal IOMEM accesses, you need to only use the magic mmio-config
+ * on their northbridge except through the * %eax register. As such, you MUST
+ * NOT use normal IOMEM accesses, you need to only use the magic mmio_config_*
  * accessor functions.
- * In fact just use pci_config_*, nothing else please.
+ *
+ * Please refer to the following doc:
+ * "BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors",
+ * rev. 3.48, sec 2.11.1, "MMIO Configuration Coding Requirements".
  */
 static inline unsigned char mmio_config_readb(void __iomem *pos)
 {
-- 
1.9.1
