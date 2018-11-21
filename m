From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Nov 2018 10:35:18 +0100
Subject: [PATCH 07/12] ARM: davinci: da850: set the GPIO base to 0
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
Message-ID: <20181121093523.12503-8-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the network support in legacy boot
mode for da850-evm since we can no longer request the MDIO clock GPIO.

We now have the option to specify the GPIO base manually for davinci,
so add the relevant fields to platform data.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable at vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4528bbf0c861..e7b78df2bfef 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -719,7 +719,9 @@ int __init da850_register_vpif_capture(struct vpif_capture_config
 }
 
 static struct davinci_gpio_platform_data da850_gpio_platform_data = {
-	.ngpio = 144,
+	.no_auto_base	= true,
+	.base		= 0,
+	.ngpio		= 144,
 };
 
 int __init da850_register_gpio(void)
-- 
2.19.1
