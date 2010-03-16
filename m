From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Mar 2010 08:35:38 +0200
Subject: [PATCH 2/3] mx1: fix build when DEBUG_LL is enabled
In-Reply-To: <20100311105637.GE16376@n2100.arm.linux.org.uk>
References: <20100311105637.GE16376@n2100.arm.linux.org.uk>
Message-ID: <13f9bd0888fe0d522a149a15be5b370c086ca379.1268721011.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "mx1: prefix SOC specific defines with MX1_ and deprecate old names"
redefined the IO_ADDRESS macro in a way that is incompatible with
debug-macro.S. Use MX1_IO_ADDRESS instead.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 133d66b..4c7d9f8 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -15,7 +15,7 @@
 #ifdef CONFIG_ARCH_MX1
 #include <mach/mx1.h>
 #define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_VADDR	MX1_IO_ADDRESS(UART1_BASE_ADDR)
 #endif
 
 #ifdef CONFIG_ARCH_MX25
-- 
1.7.0
