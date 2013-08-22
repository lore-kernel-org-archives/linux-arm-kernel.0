From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 22 Aug 2013 17:47:50 +0100
Subject: [PATCH 3/3] ARM: PCI: versatile: Fix SMAP register offsets
In-Reply-To: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
References: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <1377190070-7305-4-git-send-email-peter.maydell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMAP register offsets in the versatile PCI controller code were
all off by four.  (This didn't have any observable bad effects
because on this board PHYS_OFFSET is zero, and (a) writing zero to
the flags register at offset 0x10 has no effect and (b) the reset
value of the SMAP register is zero anyway, so failing to write SMAP2
didn't matter.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 arch/arm/mach-versatile/pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 1e48878..c97be4e 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -43,9 +43,9 @@
 #define PCI_IMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x0)
 #define PCI_IMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x4)
 #define PCI_IMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x8)
-#define PCI_SMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x10)
-#define PCI_SMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x14)
-#define PCI_SMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x18)
+#define PCI_SMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x14)
+#define PCI_SMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x18)
+#define PCI_SMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x1c)
 #define PCI_SELFID		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0xc)
 
 #define DEVICE_ID_OFFSET		0x00
-- 
1.7.9.5
