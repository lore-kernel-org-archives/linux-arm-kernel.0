From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Sep 2013 23:41:03 +0200
Subject: [PATCH 06/10] ARM: shmobile: Initialize PWM backlight enable_gpio
 field
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Message-ID: <1379972467-11243-7-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO API defines 0 as being a valid GPIO number, so this field needs
to be initialized explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 7f8f607..6ccb854 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -423,6 +423,7 @@ static struct platform_pwm_backlight_data pwm_backlight_data = {
 	.max_brightness = 255,
 	.dft_brightness = 255,
 	.pwm_period_ns = 33333, /* 30kHz */
+	.enable_gpio = -1,
 };
 
 static struct platform_device pwm_backlight_device = {
-- 
1.8.4
