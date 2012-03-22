From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 22 Mar 2012 10:33:55 +0100
Subject: [PATCH] ARM: davinci: make all struct davinci_uart_config const and
 __initconst
Message-ID: <1332408835-22030-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm not sure it's worth to do this because I guess it becomes obsolete when
davinci is converted to dt. But as I did the patch and I don't know
when/if davinci is converted I'm sending it anyhow.

Best regards
Uwe

 arch/arm/mach-davinci/board-da830-evm.c     |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    3 ++-
 arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h |    2 +-
 arch/arm/mach-davinci/serial.c              |    2 +-
 13 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index dc1afe5..a4976dc 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -185,7 +185,7 @@ static __init void da830_evm_usb_init(void)
 			   __func__, ret);
 }
 
-static struct davinci_uart_config da830_evm_uart_config __initdata = {
+static const struct davinci_uart_config da830_evm_uart_config __initconst = {
 	.enabled_uarts = 0x7,
 };
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index d508890..1ca1e56 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -734,7 +734,7 @@ static struct davinci_i2c_platform_data da850_evm_i2c_0_pdata = {
 	.bus_delay	= 0,	/* usec */
 };
 
-static struct davinci_uart_config da850_evm_uart_config __initdata = {
+static const struct davinci_uart_config da850_evm_uart_config __initconst = {
 	.enabled_uarts = 0x7,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 275341f..e5ebe57 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -246,7 +246,7 @@ static struct platform_device *davinci_evm_devices[] __initdata = {
 	&davinci_nand_device,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index e99db28..f21e2d4 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -171,7 +171,7 @@ static struct platform_device *davinci_leopard_devices[] __initdata = {
 	&davinci_nand_device,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 849311d..35cecc0 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -557,7 +557,7 @@ fail:
 	/* REVISIT export switches: NTSC/PAL (SW5.6), EXTRA1 (SW5.2), etc */
 }
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 1247ecd..8e204e1 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -617,7 +617,7 @@ static struct platform_device *davinci_evm_devices[] __initdata = {
 	&rtc_dev,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 872ac69..d4b7b53 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -732,7 +732,7 @@ static void __init davinci_map_io(void)
 	cdce_clk_init();
 }
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 672d820..9432ae2 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -434,7 +434,7 @@ static void __init mityomapl138_setup_nand(void)
 				 ARRAY_SIZE(mityomapl138_devices));
 }
 
-static struct davinci_uart_config mityomapl138_uart_config __initdata = {
+static const struct davinci_uart_config mityomapl138_uart_config __initconst = {
 	.enabled_uarts = 0x7,
 };
 
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 8d34f51..adaf8cd 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -152,7 +152,7 @@ static struct platform_device *davinci_ntosd2_devices[] __initdata = {
 	&ntosd2_leds_dev,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 45e8157..5f5e0ac 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -293,7 +293,8 @@ usb11_setup_oc_fail:
 	gpio_free(DA850_USB1_VBUS_PIN);
 }
 
-static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
+static const struct davinci_uart_config
+		omapl138_hawk_uart_config __initconst = {
 	.enabled_uarts = 0x7,
 };
 
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 31da3c5..0fdd0cb 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -124,7 +124,7 @@ static struct platform_device *davinci_sffsdr_devices[] __initdata = {
 	&davinci_sffsdr_nandflash_device,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
+static const struct davinci_uart_config uart_config __initconst = {
 	.enabled_uarts = (1 << 0),
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 46b3cd1..2429aee 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -42,7 +42,7 @@ struct davinci_uart_config {
 	unsigned int enabled_uarts;
 };
 
-extern int davinci_serial_init(struct davinci_uart_config *);
+extern int davinci_serial_init(const struct davinci_uart_config *);
 #endif
 
 #endif /* __ASM_ARCH_SERIAL_H */
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 1875740..0d054c4 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -70,7 +70,7 @@ static void __init davinci_serial_reset(struct plat_serial8250_port *p)
 				 UART_DM646X_SCR_TX_WATERMARK);
 }
 
-int __init davinci_serial_init(struct davinci_uart_config *info)
+int __init davinci_serial_init(const struct davinci_uart_config *info)
 {
 	int i;
 	char name[16];
-- 
1.7.9.1
