From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Sat,  9 Jul 2011 15:51:53 -0700
Subject: [PATCH 1/1] ARM: i.MX50/53: debug-macro: fix UART_PADDR
Message-ID: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX51 UART_PADDR value does not work for MX50/53.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 8e8d175..3919ad4 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -37,13 +37,20 @@
 #define UART_PADDR	MX3x_UART1_BASE_ADDR
 #endif
 
-#ifdef CONFIG_ARCH_MX5
+#ifdef CONFIG_ARCH_MX51
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #endif
 
+#if defined(CONFIG_ARCH_MX50) || defined(CONFIG_ARCH_MX53)
+#ifdef UART_PADDR
+#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
+#endif
+#define UART_PADDR	MX53_UART1_BASE_ADDR
+#endif
+
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
 
 		.macro	addruart, rp, rv
-- 
1.7.0.4
