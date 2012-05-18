From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 18 May 2012 21:12:34 +0800
Subject: [PATCH RFC v2 1/2] pinctrl: add pinctrl_add_gpio_ranges function
Message-ID: <1337346755-8761-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/core.c          |   22 ++++++++++++++++++++++
 include/linux/pinctrl/pinctrl.h |    6 ++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index c3b331b..916ed49 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -346,6 +346,28 @@ void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinctrl_remove_gpio_range);
 
+void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
+			     struct pinctrl_gpio_range *ranges,
+			     unsigned nranges)
+{
+	int i;
+
+	for (i = 0; i < nranges; i++)
+		pinctrl_add_gpio_range(pctldev, &ranges[i]);
+}
+EXPORT_SYMBOL_GPL(pinctrl_add_gpio_ranges);
+
+void pinctrl_remove_gpio_ranges(struct pinctrl_dev *pctldev,
+				struct pinctrl_gpio_range *ranges,
+				unsigned nranges)
+{
+	int i;
+
+	for (i = 0; i < nranges; i++)
+		pinctrl_remove_gpio_range(pctldev, &ranges[i]);
+}
+EXPORT_SYMBOL_GPL(pinctrl_remove_gpio_ranges);
+
 /**
  * pinctrl_get_group_selector() - returns the group selector for a group
  * @pctldev: the pin controller handling the group
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 3b894a6..6a29965 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -133,6 +133,12 @@ extern void pinctrl_add_gpio_range(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *range);
 extern void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *range);
+extern void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
+			     struct pinctrl_gpio_range *ranges,
+			     unsigned nranges);
+extern void pinctrl_remove_gpio_ranges(struct pinctrl_dev *pctldev,
+				struct pinctrl_gpio_range *ranges,
+				unsigned nranges);
 extern const char *pinctrl_dev_get_name(struct pinctrl_dev *pctldev);
 extern void *pinctrl_dev_get_drvdata(struct pinctrl_dev *pctldev);
 #else
-- 
1.7.0.4
