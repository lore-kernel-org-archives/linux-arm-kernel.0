From: joe@perches.com (Joe Perches)
Date: Sat, 13 Sep 2014 11:31:14 -0700
Subject: [PATCH 3/8] arm: mach-ep93xx: Convert pr_warning to pr_warn
In-Reply-To: <cover.1410632834.git.joe@perches.com>
References: <cover.1410632834.git.joe@perches.com>
Message-ID: <eeb86791d228154bba61fb9eca83e24a25376201.1410632835.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the more common pr_warn.

Other miscellanea:

o Coalesce formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-ep93xx/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 0e571f1..c75c678 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -454,9 +454,9 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
 	 * CMOS driver.
 	 */
 	if (data->sda_is_open_drain && data->sda_pin != EP93XX_GPIO_LINE_EEDAT)
-		pr_warning("sda != EEDAT, open drain has no effect\n");
+		pr_warn("sda != EEDAT, open drain has no effect\n");
 	if (data->scl_is_open_drain && data->scl_pin != EP93XX_GPIO_LINE_EECLK)
-		pr_warning("scl != EECLK, open drain has no effect\n");
+		pr_warn("scl != EECLK, open drain has no effect\n");
 
 	__raw_writel((data->sda_is_open_drain << 1) |
 		     (data->scl_is_open_drain << 0),
-- 
1.8.1.2.459.gbcd45b4.dirty
