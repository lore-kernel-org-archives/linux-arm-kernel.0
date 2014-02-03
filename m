From: mporter@linaro.org (Matt Porter)
Date: Mon,  3 Feb 2014 08:40:31 -0500
Subject: [PATCH v2 5/6] pwm: enable TI PWMSS if the IIO tiecap driver is
 selected
In-Reply-To: <1391434832-23807-1-git-send-email-mporter@linaro.org>
References: <1391434832-23807-1-git-send-email-mporter@linaro.org>
Message-ID: <1391434832-23807-6-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IIO TI ECAP driver depends on the TI PWMSS management
driver in this subsystem. Enable PWMSS when the IIO TI ECAP
driver is selected.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 22f2f28..bd3cc65 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -219,7 +219,7 @@ config  PWM_TIEHRPWM
 
 config  PWM_TIPWMSS
 	bool
-	default y if SOC_AM33XX && (PWM_TIECAP || PWM_TIEHRPWM)
+	default y if SOC_AM33XX && (IIO_TIECAP || PWM_TIECAP || PWM_TIEHRPWM)
 	help
 	  PWM Subsystem driver support for AM33xx SOC.
 
-- 
1.8.4
