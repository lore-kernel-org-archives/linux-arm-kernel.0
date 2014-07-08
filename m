From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Jul 2014 17:11:42 +0200
Subject: [PATCH 2/3] ARM: msm: remove reference to MSM_SERIAL_DEBUGGER
In-Reply-To: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
References: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1404832303-14850-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a dangling symbol in the kernel: there is no config option
for the MSM_SERIAL_DEBUGGER anywhere in the kernel.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-msm/board-msm7x30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 245884319d2e..8f5ecdc4f3ce 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -124,7 +124,7 @@ struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
 static struct platform_device *devices[] __initdata = {
 	&msm_clock_7x30,
 	&msm_device_gpio_7x30,
-#if defined(CONFIG_SERIAL_MSM) || defined(CONFIG_MSM_SERIAL_DEBUGGER)
+#if defined(CONFIG_SERIAL_MSM)
         &msm_device_uart2,
 #endif
 	&msm_device_smd,
-- 
1.9.3
