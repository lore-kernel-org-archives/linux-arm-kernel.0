From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 20 Nov 2018 13:31:25 +0100
Subject: [PATCH 5/5] ARM: davinci: dm644x: set the GPIO base to 0
In-Reply-To: <20181120123125.24938-1-brgl@bgdev.pl>
References: <20181120123125.24938-1-brgl@bgdev.pl>
Message-ID: <20181120123125.24938-6-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/dm644x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0720da7809a6..f25b508a831b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -498,6 +498,8 @@ static struct resource dm644_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm644_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 71,
 };
 
-- 
2.19.1
