From: vigneshr@ti.com (Vignesh R)
Date: Wed, 2 Aug 2017 11:43:44 +0530
Subject: [PATCH] pwm: Kconfig: Enable pwm-tiecap to be built for Keystone
Message-ID: <20170802061344.1713-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

66AK2G SoC has ECAP subsystem that is used as pwm-backlight provider for
display. Hence, enable pwm-tiecap driver to be built for Keystone
architecture.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 313c10789ca2..c7f3a6037c93 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -446,7 +446,7 @@ config PWM_TEGRA
 
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
 	help
 	  PWM driver support for the ECAP APWM controller found on AM33XX
 	  TI SOC
-- 
2.13.3
