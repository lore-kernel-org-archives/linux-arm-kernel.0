From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Jul 2010 18:21:23 +0200
Subject: [PATCH v3 8/8] ARM: s5pv210: Override FIMC driver name on Aquila board
In-Reply-To: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279902083-21250-9-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change variant of the FIMC driver for compatibility with older
SoC version (EVT0) used on Aquila board.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 7528514..c6cc3f5 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -36,6 +36,7 @@
 #include <plat/cpu.h>
 #include <plat/fb.h>
 #include <plat/fimc.h>
+#include <plat/fimc-core.h>
 
 #include "common-aquila-goni.h"
 
@@ -467,6 +468,10 @@ static void __init aquila_machine_init(void)
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
 			ARRAY_SIZE(i2c_gpio_pmic_devs));
 
+	s3c_fimc_setname(0, "s5p-fimc");
+	s3c_fimc_setname(1, "s5p-fimc");
+	s3c_fimc_setname(2, "s5p-fimc");
+
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
-- 
1.7.2
