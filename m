From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 26 May 2015 19:39:46 +0200
Subject: [PATCH] ARM: lpc18xx: remove DEBUG_LL_UART_8250 from defconfig
Message-ID: <1432661986-4118-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the generic 8250 config option so that the LPC18xx
specific option gets picked instead.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi Arnd,

Please apply this to the next/defconfig branch.

After LPC18XX was converted to use the DEBUG_LPC18XX_UART0 config
symbol there is now a mismatch in defconfig for this platform.

On a clean defconfig the following warnings appear.
.config:2073:warning: symbol value '' invalid for DEBUG_UART_PHYS
.config:2074:warning: symbol value '' invalid for DEBUG_UART_VIRT

Since the default value now depends on DEBUG_LPC18XX_UART0 and not
ARCH_LPC18XX.

 arch/arm/configs/lpc18xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index d4320a7e433f..1c47f86c3970 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -146,7 +146,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_RCU_CPU_STALL_INFO is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
-- 
1.8.0
