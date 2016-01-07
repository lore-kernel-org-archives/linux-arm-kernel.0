From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  6 Jan 2016 17:12:49 -0800
Subject: [PATCH 3/3] Revert "pinctrl: qcom: make PMIC drivers bool"
In-Reply-To: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
References: <1452129169-2014-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1452129169-2014-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit bda7c4c2b9767ce2af4394754498662d62079af5.
These drivers build as modules now that we use
platform_irq_count() instead of of_irq_count().

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index c658d9bce285..eeac8cba8a21 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -80,7 +80,7 @@ config PINCTRL_QDF2XXX
 	  Qualcomm Technologies QDF2xxx SOCs.
 
 config PINCTRL_QCOM_SPMI_PMIC
-       bool "Qualcomm SPMI PMIC pin controller driver"
+       tristate "Qualcomm SPMI PMIC pin controller driver"
        depends on GPIOLIB && OF && SPMI
        select REGMAP_SPMI
        select PINMUX
@@ -93,7 +93,7 @@ config PINCTRL_QCOM_SPMI_PMIC
          devices are pm8841, pm8941 and pma8084.
 
 config PINCTRL_QCOM_SSBI_PMIC
-       bool "Qualcomm SSBI PMIC pin controller driver"
+       tristate "Qualcomm SSBI PMIC pin controller driver"
        depends on GPIOLIB && OF
        select PINMUX
        select PINCONF
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
