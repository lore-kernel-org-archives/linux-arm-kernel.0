From: vigneshr@ti.com (Vignesh R)
Date: Tue, 16 Oct 2018 11:34:02 +0530
Subject: [PATCH v2 2/2] pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
In-Reply-To: <20181016060402.18756-1-vigneshr@ti.com>
References: <20181016060402.18756-1-vigneshr@ti.com>
Message-ID: <20181016060402.18756-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

K3 devices have the same ECAP IP as OMAP SoCs. Enable driver to be built
for K3 devices. Also, drop reference to AM33xx in help text, as IP is
found on multiple TI SoCs.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
v2: Update help text to drop AM33xx as suggested by Andrew

 drivers/pwm/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d252716f2..27e5dd47a01f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -447,10 +447,9 @@ config PWM_TEGRA
 
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
 	help
-	  PWM driver support for the ECAP APWM controller found on AM33XX
-	  TI SOC
+	  PWM driver support for the ECAP APWM controller found on TI SOCs
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiecap.
-- 
2.19.1
