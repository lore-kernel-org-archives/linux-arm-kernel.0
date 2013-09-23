From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Sep 2013 23:41:04 +0200
Subject: [PATCH 07/10] unicore32: Initialize PWM backlight enable_gpio field
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Message-ID: <1379972467-11243-8-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO API defines 0 as being a valid GPIO number, so this field needs
to be initialized explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/unicore32/kernel/puv3-nb0916.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..0c6618e 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -54,6 +54,7 @@ static struct platform_pwm_backlight_data nb0916_backlight_data = {
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 70 * 1024,
+	.enable_gpio	= -1,
 };
 
 static struct gpio_keys_button nb0916_gpio_keys[] = {
-- 
1.8.4
