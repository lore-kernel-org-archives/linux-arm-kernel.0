From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Mar 2013 10:59:33 +0800
Subject: [PATCH] ARM: imx: add dependency check for DEBUG_IMX_UART_PORT
Message-ID: <1363143573-11900-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adding i.MX DEBUG_LL selection, commit f8c95fe (ARM: imx: support
DEBUG_LL uart port selection for all i.MX SoCs) leaves Kconfig symbol
DEBUG_IMX_UART_PORT there without any dependency check.  This results in
that everyone gets the symbol in their config, which is someting
undesirable.  Add "depends on ARCH_MXC" for the symbol to prevent that.

Reported-by: Karl Beldan <karl.beldan@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ecfcdba..9b31f43 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -495,6 +495,7 @@ config DEBUG_IMX_UART_PORT
 						DEBUG_IMX53_UART || \
 						DEBUG_IMX6Q_UART
 	default 1
+	depends on ARCH_MXC
 	help
 	  Choose UART port on which kernel low-level debug messages
 	  should be output.
-- 
1.7.9.5
