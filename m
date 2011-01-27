From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:25 +0100
Subject: [PATCH 05/13] ARM i.MX31 mx31ads: remove unnecessary
	CONFIG_SERIAL_8250 ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31ads.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 1a83dc5..e40eb6e 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -73,8 +73,7 @@
  * This file contains the board-specific initialization routines.
  */
 
-#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
-/*!
+/*
  * The serial port definition structure.
  */
 static struct plat_serial8250_port serial_platform_data[] = {
@@ -110,12 +109,6 @@ static int __init mxc_init_extuart(void)
 {
 	return platform_device_register(&serial_device);
 }
-#else
-static inline int mxc_init_extuart(void)
-{
-	return 0;
-}
-#endif
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
-- 
1.7.2.3
