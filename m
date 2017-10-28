From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Oct 2017 15:37:16 +0200
Subject: [PATCH 1/4] pinctrl: gemini: Add missing functions
Message-ID: <20171028133719.27528-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some two functions were missing from the Gemini pin control
driver. Noticed when trying to use ethernet. Fix it up by
adding them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-gemini.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-gemini.c b/drivers/pinctrl/pinctrl-gemini.c
index 39e6221e7100..7ffd768c0e02 100644
--- a/drivers/pinctrl/pinctrl-gemini.c
+++ b/drivers/pinctrl/pinctrl-gemini.c
@@ -2074,6 +2074,16 @@ static const struct gemini_pmx_func gemini_pmx_functions[] = {
 		.num_groups = ARRAY_SIZE(satagrps),
 	},
 	{
+		.name = "usb",
+		.groups = usbgrps,
+		.num_groups = ARRAY_SIZE(usbgrps),
+	},
+	{
+		.name = "gmii",
+		.groups = gmiigrps,
+		.num_groups = ARRAY_SIZE(gmiigrps),
+	},
+	{
 		.name = "pci",
 		.groups = pcigrps,
 		.num_groups = ARRAY_SIZE(pcigrps),
-- 
2.13.6
