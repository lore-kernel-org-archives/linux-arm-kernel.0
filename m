From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jun 2016 02:32:01 +0200
Subject: [PATCH] pinctrl: qcom-ssbi: support for pm8058
Message-ID: <1465777921-1989-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PM858 is found in connection to the APQ8060 on the APQ8060
Dragonboard. Works the same as all others, just add the compatible
string for this variant.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt | 1 +
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c                     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
index d74e631e10da..b484ba1af78c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
@@ -9,6 +9,7 @@ of PMIC's from Qualcomm.
 	Definition: Should contain one of:
 		    "qcom,pm8018-mpp",
 		    "qcom,pm8038-mpp",
+		    "qcom,pm8058-mpp",
 		    "qcom,pm8821-mpp",
 		    "qcom,pm8841-mpp",
 		    "qcom,pm8916-mpp",
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 9191727aff5e..0d1392fc32dd 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -744,6 +744,7 @@ static int pm8xxx_pin_populate(struct pm8xxx_mpp *pctrl,
 static const struct of_device_id pm8xxx_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8018-mpp" },
 	{ .compatible = "qcom,pm8038-mpp" },
+	{ .compatible = "qcom,pm8058-mpp" },
 	{ .compatible = "qcom,pm8917-mpp" },
 	{ .compatible = "qcom,pm8821-mpp" },
 	{ .compatible = "qcom,pm8921-mpp" },
-- 
2.4.11
