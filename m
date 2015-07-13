From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 13 Jul 2015 14:31:36 -0700
Subject: [PATCH] arm64: Define HAVE_ARCH_PIO_SIZE and related symbols.
Message-ID: <1436823096-24059-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Needed to make pci_iomap() work.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 540f7c0..8ef78d5 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -149,6 +149,11 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
+#define HAVE_ARCH_PIO_SIZE	1
+#define PIO_RESERVED		SZ_32M
+#define PIO_OFFSET		0
+#define PIO_MASK		(PIO_RESERVED - 1)
+
 /*
  * String version of I/O memory access operations.
  */
-- 
1.7.11.7
