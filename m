From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 24 May 2010 18:57:17 +0530
Subject: [PATCH 5/7] nomadik-gpio: switch to core_initcall
In-Reply-To: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
References: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1274707639-28285-5-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the platform driver registration to a core_initcall, instead of an
arch_initcall.  This will allow us to use gpio related calls in
init_machine() (which is an arch_initcall) after adding the gpio
platform devices.

Cc: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 983a2e8..5fe17bf 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -616,7 +616,7 @@ static int __init nmk_gpio_init(void)
 	return platform_driver_register(&nmk_gpio_driver);
 }
 
-arch_initcall(nmk_gpio_init);
+core_initcall(nmk_gpio_init);
 
 MODULE_AUTHOR("Prafulla WADASKAR and Alessandro Rubini");
 MODULE_DESCRIPTION("Nomadik GPIO Driver");
-- 
1.7.0
