From: joe@perches.com (Joe Perches)
Date: Thu, 16 Feb 2017 23:11:15 -0800
Subject: [PATCH 02/35] ARM: ep93xx: Convert remaining uses of pr_warning to
 pr_warn
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Message-ID: <aa5b8db51f4ee0aaf27ebacbe0d1d35112147952.1487314666.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable eventual removal of pr_warning.

This makes pr_warn use consistent for arch/arm

Prior to this patch, there were 2 uses of pr_warning and
405 uses of pr_warn in arch/arm

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-ep93xx/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c393b1b0310d..d6e907b6cc31 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -346,9 +346,9 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
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
2.10.0.rc2.1.g053435c
