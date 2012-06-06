From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:34:57 +0200
Subject: [PATCH 3/7] ARM: nomadik: register PL031 RTC
Message-ID: <1339018497-29057-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This registers the PL031 derivate found in the Nomadik 8815
SoCs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index c0f28a6..88511fe 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -92,6 +92,7 @@ static int __init cpu8815_init(void)
 	cpu8815_add_gpios(cpu8815_gpio_base, ARRAY_SIZE(cpu8815_gpio_base),
 			  IRQ_GPIO0, &pdata);
 	amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
+	amba_apb_device_add(NULL, "rtc-pl031", NOMADIK_RTC_BASE, SZ_4K, IRQ_RTC_RTT, 0, NULL, 0);
 	return 0;
 }
 arch_initcall(cpu8815_init);
-- 
1.7.7.6
