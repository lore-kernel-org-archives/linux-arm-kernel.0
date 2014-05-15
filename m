From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 15 May 2014 12:39:55 +0200
Subject: [PATCH] ARM: msm: remove check for CONFIG_MSM_SERIAL_DEBUGGER
Message-ID: <1400150395.9119.3.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An (optional) check for CONFIG_MSM_SERIAL_DEBUGGER was added in v2.6.35.
But the related Kconfig symbol was never added to the tree. This check
will always evaluate to false. Remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

There's another check for CONFIG_MSM_SERIAL_DEBUGGER in
board-mahimahi.c. But I submitted a patch to drop that entire board file
in https://lkml.org/lkml/2014/5/14/631 .

 arch/arm/mach-msm/board-msm7x30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 46de789ad3ae..e3c646cc7765 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -125,7 +125,7 @@ struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
 static struct platform_device *devices[] __initdata = {
 	&msm_clock_7x30,
 	&msm_device_gpio_7x30,
-#if defined(CONFIG_SERIAL_MSM) || defined(CONFIG_MSM_SERIAL_DEBUGGER)
+#if defined(CONFIG_SERIAL_MSM)
         &msm_device_uart2,
 #endif
 	&msm_device_smd,
-- 
1.9.0
