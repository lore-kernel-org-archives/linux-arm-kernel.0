From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:06 +0800
Subject: [PATCH v7 02/15] pinctrl: core: get devname from pinctrl_dev
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new function to get devname from pinctrl_dev. pinctrl_dev_get_name()
can only get pinctrl description name. If we want to use gpio driver to
find pinctrl device node, we need to fetch the pinctrl device name.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/core.c          |    6 ++++++
 include/linux/pinctrl/pinctrl.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 59f5a96..e7378a1 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -83,6 +83,12 @@ const char *pinctrl_dev_get_name(struct pinctrl_dev *pctldev)
 }
 EXPORT_SYMBOL_GPL(pinctrl_dev_get_name);
 
+const char *pinctrl_dev_get_devname(struct pinctrl_dev *pctldev)
+{
+	return dev_name(pctldev->dev);
+}
+EXPORT_SYMBOL_GPL(pinctrl_dev_get_devname);
+
 void *pinctrl_dev_get_drvdata(struct pinctrl_dev *pctldev)
 {
 	return pctldev->driver_data;
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 04d6700..778804d 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -154,6 +154,7 @@ struct pinctrl_dev *of_pinctrl_get(struct device_node *np)
 #endif /* CONFIG_OF */
 
 extern const char *pinctrl_dev_get_name(struct pinctrl_dev *pctldev);
+extern const char *pinctrl_dev_get_devname(struct pinctrl_dev *pctldev);
 extern void *pinctrl_dev_get_drvdata(struct pinctrl_dev *pctldev);
 #else
 
-- 
1.7.10.4
