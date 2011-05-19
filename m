From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 18:47:27 +0200
Subject: [PATCH 7/8] ARM i.MX debug macro: use CONFIG_SOC_* instead of
	CONFIG_ARCH_*
In-Reply-To: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305823648-2428-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ARCH_* are deprecated, so remove one user.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 8e8d175..75a8933 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -12,32 +12,32 @@
  */
 #include <mach/hardware.h>
 
-#ifdef CONFIG_ARCH_MX1
+#ifdef CONFIG_SOC_IMX1
 #define UART_PADDR	MX1_UART1_BASE_ADDR
 #endif
 
-#ifdef CONFIG_ARCH_MX25
+#ifdef CONFIG_SOC_IMX25
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
 #define UART_PADDR	MX25_UART1_BASE_ADDR
 #endif
 
-#ifdef CONFIG_ARCH_MX2
+#if defined CONFIG_SOC_IMX21 || defined CONFIG_SOC_IMX27
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
 #define UART_PADDR	MX2x_UART1_BASE_ADDR
 #endif
 
-#ifdef CONFIG_ARCH_MX3
+#if defined CONFIG_SOC_IMX31 || defined CONFIG_SOC_IMX35
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
 #define UART_PADDR	MX3x_UART1_BASE_ADDR
 #endif
 
-#ifdef CONFIG_ARCH_MX5
+#ifdef CONFIG_SOC_IMX51
 #ifdef UART_PADDR
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
-- 
1.7.4.1
