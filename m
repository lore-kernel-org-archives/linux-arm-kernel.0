From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:52 +0100
Subject: [PATCH 7/9] plat-nomadik: set altfunc to GPIO when enabling the sleep
	config
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-8-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index cc9de59..bf299cf 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -175,6 +175,8 @@ static void __nmk_config_pin(struct nmk_gpio_chip *nmk_chip, unsigned offset,
 		int slpm_output = PIN_SLPM_DIR(cfg);
 		int slpm_val = PIN_SLPM_VAL(cfg);
 
+		af = NMK_GPIO_ALT_GPIO;
+
 		/*
 		 * The SLPM_* values are normal values + 1 to allow zero to
 		 * mean "same as normal".
-- 
1.7.3.2
