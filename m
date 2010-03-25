From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Thu, 25 Mar 2010 09:50:57 +0100
Subject: [PATCH] i.MX25: Define address mapping macros
Message-ID: <20100325085057.GG2328@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macros for mapping physical addresses of i.MX25 registers to virtual
addresses

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 arch/arm/plat-mxc/include/mach/mx25.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 4eb6e33..4821fcd 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -27,6 +27,19 @@
 	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
 	IMX_IO_ADDRESS(x, MX25_AVIC))
 
+/*
+ * define the address mapping macros: in physical address order
+ */
+
+#define MX25_AIPS1_IO_ADDRESS(x)  \
+	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
+
+#define MX25_AIPS2_IO_ADDRESS(x)  \
+	(((x) - MX25_AIPS2_BASE_ADDR) + MX25_AIPS2_BASE_ADDR_VIRT)
+
+#define MX25_AVIC_IO_ADDRESS(x)  \
+	(((x) - MX25_AVIC_BASE_ADDR) + MX25_AVIC_BASE_ADDR_VIRT)
+
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
 
-- 
1.6.5
