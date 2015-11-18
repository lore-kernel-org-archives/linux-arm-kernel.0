From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 16:52:32 -0800
Subject: [PATCH 1/2] pinctrl: qcom: spmi-gpio: Add pm8994 gpio support
In-Reply-To: <1447807953-11924-1-git-send-email-sboyd@codeaurora.org>
References: <1447807953-11924-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1447807953-11924-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the binding and driver for pm8994-gpio devices.

Cc: <devicetree@vger.kernel.org>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 2 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index 1ae63c0acd40..a90c812ad642 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -14,6 +14,7 @@ PMIC's from Qualcomm.
 		    "qcom,pm8917-gpio"
 		    "qcom,pm8921-gpio"
 		    "qcom,pm8941-gpio"
+		    "qcom,pm8994-gpio"
 		    "qcom,pma8084-gpio"
 
 - reg:
@@ -79,6 +80,7 @@ to specify in a pin configuration subnode:
 		    gpio1-gpio38 for pm8917
 		    gpio1-gpio44 for pm8921
 		    gpio1-gpio36 for pm8941
+		    gpio1-gpio22 for pm8994
 		    gpio1-gpio22 for pma8084
 
 - function:
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 6c42ca14d2fd..df4413023e21 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -804,6 +804,7 @@ static int pmic_gpio_remove(struct platform_device *pdev)
 static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
 	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
+	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
 	{ },
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
