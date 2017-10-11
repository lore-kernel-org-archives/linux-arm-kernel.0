From: jim2101024@gmail.com (Jim Quinlan)
Date: Wed, 11 Oct 2017 18:34:26 -0400
Subject: [PATCH 6/9] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for MIPS
In-Reply-To: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
Message-ID: <1507761269-7017-7-git-send-email-jim2101024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
generation of msi.h in the MIPS arch.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/Kbuild | 1 +
 drivers/pci/Kconfig          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7c8aab2..8c78ba7 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index c32a77f..927c335 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -25,7 +25,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || MIPS || X86
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
1.9.0.138.g2de3478
