From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 20 Nov 2018 13:31:23 +0100
Subject: [PATCH 3/5] ARM: davinci: dm355: set the GPIO base to 0
In-Reply-To: <20181120123125.24938-1-brgl@bgdev.pl>
References: <20181120123125.24938-1-brgl@bgdev.pl>
Message-ID: <20181120123125.24938-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable at vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9f7d38d12c88..73f2f70ce729 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -554,6 +554,8 @@ static struct resource dm355_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm355_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 104,
 };
 
-- 
2.19.1
