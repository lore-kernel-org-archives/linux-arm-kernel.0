From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Mar 2010 08:35:39 +0200
Subject: [PATCH 3/3] mx25: fix build when DEBUG_LL is enabled
In-Reply-To: <20100311105637.GE16376@n2100.arm.linux.org.uk>
References: <20100311105637.GE16376@n2100.arm.linux.org.uk>
Message-ID: <da11b37fde9654572dad78b514ba49864ac0fcd2.1268721011.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Greshgorin <alexg@orex-cr.com>

Commit "imx25: redefine MX25_IO_ADDRESS using IMX_IO_ADDRESS" removed the
MX25_AIPS1_IO_ADDRESS macro which is used in debug-macro.S. Include
mach/hardware.h, and use the higher level IMX_IO_ADDRESS which is assembly
compatible

Signed-off-by: Alex Greshgorin <alexg@orex-cr.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 4c7d9f8..da75db8 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -22,9 +22,9 @@
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-#include <mach/mx25.h>
+#include <mach/hardware.h>
 #define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	MX25_AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_VADDR	IMX_IO_ADDRESS(UART1_BASE_ADDR, MX25_AIPS1)
 #endif
 
 #ifdef CONFIG_ARCH_MX2
-- 
1.7.0
