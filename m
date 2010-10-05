From: jc.lee@samsung.com (Jaecheol Lee)
Date: Tue,  5 Oct 2010 21:28:56 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix on default of s3c24xx_uart_devs
Message-ID: <1286281736-29821-1-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds default dev->bus, platform_bus_type of s3c24xx_uart_devs.
If there is no default dev->bus, we cannot get the proper clock 'id' from
clk_get() in the console_initcall().
This problem occurs when only defined 'uclk1' as uart clock.

Reported-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/plat-samsung/dev-uart.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
index 3776cd9..519e1bc 100644
--- a/arch/arm/plat-samsung/dev-uart.c
+++ b/arch/arm/plat-samsung/dev-uart.c
@@ -19,18 +19,22 @@
 
 static struct platform_device s3c24xx_uart_device0 = {
 	.id		= 0,
+	.dev		= { .bus = &platform_bus_type },
 };
 
 static struct platform_device s3c24xx_uart_device1 = {
 	.id		= 1,
+	.dev		= { .bus = &platform_bus_type },
 };
 
 static struct platform_device s3c24xx_uart_device2 = {
 	.id		= 2,
+	.dev		= { .bus = &platform_bus_type },
 };
 
 static struct platform_device s3c24xx_uart_device3 = {
 	.id		= 3,
+	.dev		= { .bus = &platform_bus_type },
 };
 
 struct platform_device *s3c24xx_uart_src[4] = {
-- 
1.6.2.5
