From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Dec 2015 13:31:10 +0100
Subject: [PATCH] pinctrl: qcom: make PMIC drivers bool
Message-ID: <1451046670-11032-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit ab4256cfeab91569e1d96e7f0014538fe0845259
"pinctrl: qcom: pmic-gpio/mpp: of_irq_count() == npins"
made the Qualcomm PMIC pin control drivers make use of
of_irq_count() which is not an exported function, making
modular builds fail.

Fix this by marking the drivers as compiled-in/bool.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index eeac8cba8a21..c658d9bce285 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -80,7 +80,7 @@ config PINCTRL_QDF2XXX
 	  Qualcomm Technologies QDF2xxx SOCs.
 
 config PINCTRL_QCOM_SPMI_PMIC
-       tristate "Qualcomm SPMI PMIC pin controller driver"
+       bool "Qualcomm SPMI PMIC pin controller driver"
        depends on GPIOLIB && OF && SPMI
        select REGMAP_SPMI
        select PINMUX
@@ -93,7 +93,7 @@ config PINCTRL_QCOM_SPMI_PMIC
          devices are pm8841, pm8941 and pma8084.
 
 config PINCTRL_QCOM_SSBI_PMIC
-       tristate "Qualcomm SSBI PMIC pin controller driver"
+       bool "Qualcomm SSBI PMIC pin controller driver"
        depends on GPIOLIB && OF
        select PINMUX
        select PINCONF
-- 
2.4.3
