From: richard.zhu@linaro.org (Richard Zhu)
Date: Thu, 22 Sep 2011 18:14:47 +0800
Subject: [V8 PATCH 4/5] MX53 Enable the AHCI SATA on MX53 LOCO board
In-Reply-To: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org>
References: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <1316686488-4684-5-git-send-email-richard.zhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_loco.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..940aac9 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -273,6 +273,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
 	imx_add_gpio_keys(&loco_button_data);
 	gpio_led_register_device(-1, &mx53loco_leds_data);
+	imx53_add_ahci_imx();
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1
