From: davidb@codeaurora.org (David Brown)
Date: Fri,  3 Jun 2011 15:44:13 -0700
Subject: [PATCH v2 1/7] msm: gpio: Remove unsupported devices
In-Reply-To: <1307141059-22431-1-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
	<1307141059-22431-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1307141059-22431-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM7x25 and MSM7x27 devices are not yet supported in the kernel.
Remove #ifdef-based tables supporting these chips for now.

Signed-off-by: David Brown <davidb@codeaurora.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-msm/gpio.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-msm/gpio.c b/arch/arm/mach-msm/gpio.c
index 5ea273b..c358ced 100644
--- a/arch/arm/mach-msm/gpio.c
+++ b/arch/arm/mach-msm/gpio.c
@@ -197,13 +197,6 @@ struct msm_gpio_chip msm_gpio_chips[] = {
 	MSM_GPIO_BANK(3,  68,  94),
 	MSM_GPIO_BANK(4,  95, 106),
 	MSM_GPIO_BANK(5, 107, 121),
-#elif defined(CONFIG_ARCH_MSM7X25) || defined(CONFIG_ARCH_MSM7X27)
-	MSM_GPIO_BANK(0,   0,  15),
-	MSM_GPIO_BANK(1,  16,  42),
-	MSM_GPIO_BANK(2,  43,  67),
-	MSM_GPIO_BANK(3,  68,  94),
-	MSM_GPIO_BANK(4,  95, 106),
-	MSM_GPIO_BANK(5, 107, 132),
 #elif defined(CONFIG_ARCH_MSM7X30)
 	MSM_GPIO_BANK(0,   0,  15),
 	MSM_GPIO_BANK(1,  16,  43),
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
