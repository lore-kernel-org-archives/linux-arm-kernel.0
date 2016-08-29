From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 29 Aug 2016 11:32:11 +0200
Subject: [PATCH] ARM: imx: use IS_ENABLED() instead of checking for built-in
 or module
Message-ID: <1472463131-29899-1-git-send-email-javier@dowhile0.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Javier Martinez Canillas <javier@osg.samsung.com>

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Using the macro makes the code more readable by helping abstract away some
of the Kconfig built-in and module enable details.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---

 arch/arm/mach-imx/mach-kzm_arm11_01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 31df4361996f..e277d9c230e5 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -63,7 +63,7 @@
  */
 #define KZM_ARM11_16550		(MX31_CS4_BASE_ADDR + 0x1050)
 
-#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
+#if IS_ENABLED(CONFIG_SERIAL_8250)
 /*
  * KZM-ARM11-01 has an external UART on FPGA
  */
@@ -141,7 +141,7 @@ static inline int kzm_init_ext_uart(void)
 /*
  * SMSC LAN9118
  */
-#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+#if IS_ENABLED(CONFIG_SMSC911X)
 static struct smsc911x_platform_config kzm_smsc9118_config = {
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
@@ -201,7 +201,7 @@ static inline int kzm_init_smsc9118(void)
 }
 #endif
 
-#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
+#if IS_ENABLED(CONFIG_SERIAL_IMX)
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
-- 
2.7.4
