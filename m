From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:37 +0530
Subject: [PATCH 2/9] serial: Remove redundant console_initcall from s3c and s5p
	console drivers
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1307594324-11053-3-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uart port is registered as a console during the driver's probe.
So explict registration of console with console_initcall is
removed.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/tty/serial/s3c2400.c |    2 --
 drivers/tty/serial/s3c2410.c |    2 --
 drivers/tty/serial/s3c2412.c |    2 --
 drivers/tty/serial/s3c2440.c |    2 --
 drivers/tty/serial/s3c24a0.c |    2 --
 drivers/tty/serial/s3c6400.c |    2 --
 drivers/tty/serial/s5pv210.c |    7 -------
 drivers/tty/serial/samsung.c |    3 ++-
 drivers/tty/serial/samsung.h |   19 -------------------
 9 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/s3c2400.c b/drivers/tty/serial/s3c2400.c
index d13051b..9d0502a 100644
--- a/drivers/tty/serial/s3c2400.c
+++ b/drivers/tty/serial/s3c2400.c
@@ -84,8 +84,6 @@ static struct platform_driver s3c2400_serial_driver = {
 	},
 };
 
-s3c24xx_console_init(&s3c2400_serial_driver, &s3c2400_uart_inf);
-
 static inline int s3c2400_serial_init(void)
 {
 	return s3c24xx_serial_init(&s3c2400_serial_driver, &s3c2400_uart_inf);
diff --git a/drivers/tty/serial/s3c2410.c b/drivers/tty/serial/s3c2410.c
index bffe6ff..b1d7e7c 100644
--- a/drivers/tty/serial/s3c2410.c
+++ b/drivers/tty/serial/s3c2410.c
@@ -96,8 +96,6 @@ static struct platform_driver s3c2410_serial_driver = {
 	},
 };
 
-s3c24xx_console_init(&s3c2410_serial_driver, &s3c2410_uart_inf);
-
 static int __init s3c2410_serial_init(void)
 {
 	return s3c24xx_serial_init(&s3c2410_serial_driver, &s3c2410_uart_inf);
diff --git a/drivers/tty/serial/s3c2412.c b/drivers/tty/serial/s3c2412.c
index 7e2b950..2234bf9 100644
--- a/drivers/tty/serial/s3c2412.c
+++ b/drivers/tty/serial/s3c2412.c
@@ -130,8 +130,6 @@ static struct platform_driver s3c2412_serial_driver = {
 	},
 };
 
-s3c24xx_console_init(&s3c2412_serial_driver, &s3c2412_uart_inf);
-
 static inline int s3c2412_serial_init(void)
 {
 	return s3c24xx_serial_init(&s3c2412_serial_driver, &s3c2412_uart_inf);
diff --git a/drivers/tty/serial/s3c2440.c b/drivers/tty/serial/s3c2440.c
index 9e10d41..1d0c324 100644
--- a/drivers/tty/serial/s3c2440.c
+++ b/drivers/tty/serial/s3c2440.c
@@ -159,8 +159,6 @@ static struct platform_driver s3c2440_serial_driver = {
 	},
 };
 
-s3c24xx_console_init(&s3c2440_serial_driver, &s3c2440_uart_inf);
-
 static int __init s3c2440_serial_init(void)
 {
 	return s3c24xx_serial_init(&s3c2440_serial_driver, &s3c2440_uart_inf);
diff --git a/drivers/tty/serial/s3c24a0.c b/drivers/tty/serial/s3c24a0.c
index 914eff2..b2931c1 100644
--- a/drivers/tty/serial/s3c24a0.c
+++ b/drivers/tty/serial/s3c24a0.c
@@ -100,8 +100,6 @@ static struct platform_driver s3c24a0_serial_driver = {
 	},
 };
 
-s3c24xx_console_init(&s3c24a0_serial_driver, &s3c24a0_uart_inf);
-
 static int __init s3c24a0_serial_init(void)
 {
 	return s3c24xx_serial_init(&s3c24a0_serial_driver, &s3c24a0_uart_inf);
diff --git a/drivers/tty/serial/s3c6400.c b/drivers/tty/serial/s3c6400.c
index ded26c4..e2f6913 100644
--- a/drivers/tty/serial/s3c6400.c
+++ b/drivers/tty/serial/s3c6400.c
@@ -130,8 +130,6 @@ static struct platform_driver s3c6400_serial_driver = {
 	},
 };
 
-s3c24xx_console_init(&s3c6400_serial_driver, &s3c6400_uart_inf);
-
 static int __init s3c6400_serial_init(void)
 {
 	return s3c24xx_serial_init(&s3c6400_serial_driver, &s3c6400_uart_inf);
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index fb2619f..d6b2423 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -135,13 +135,6 @@ static struct platform_driver s5p_serial_driver = {
 	},
 };
 
-static int __init s5pv210_serial_console_init(void)
-{
-	return s3c24xx_serial_initconsole(&s5p_serial_driver, s5p_uart_inf);
-}
-
-console_initcall(s5pv210_serial_console_init);
-
 static int __init s5p_serial_init(void)
 {
 	return s3c24xx_serial_init(&s5p_serial_driver, *s5p_uart_inf);
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 014c1c3..7ead421 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1449,7 +1449,8 @@ static struct console s3c24xx_serial_console = {
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.write		= s3c24xx_serial_console_write,
-	.setup		= s3c24xx_serial_console_setup
+	.setup		= s3c24xx_serial_console_setup,
+	.data		= &s3c24xx_uart_drv,
 };
 
 int s3c24xx_serial_initconsole(struct platform_driver *drv,
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 5b098cd..a69d9a5 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -79,25 +79,6 @@ extern int s3c24xx_serial_initconsole(struct platform_driver *drv,
 extern int s3c24xx_serial_init(struct platform_driver *drv,
 			       struct s3c24xx_uart_info *info);
 
-#ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
-
-#define s3c24xx_console_init(__drv, __inf)				\
-static int __init s3c_serial_console_init(void)				\
-{									\
-	struct s3c24xx_uart_info *uinfo[CONFIG_SERIAL_SAMSUNG_UARTS];	\
-	int i;								\
-									\
-	for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)		\
-		uinfo[i] = __inf;					\
-	return s3c24xx_serial_initconsole(__drv, uinfo);		\
-}									\
-									\
-console_initcall(s3c_serial_console_init)
-
-#else
-#define s3c24xx_console_init(drv, inf) extern void no_console(void)
-#endif
-
 #ifdef CONFIG_SERIAL_SAMSUNG_DEBUG
 
 extern void printascii(const char *);
-- 
1.6.6.rc2
