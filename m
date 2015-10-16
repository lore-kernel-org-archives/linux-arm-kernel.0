From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:41:31 +0200
Subject: [PATCH] pinctrl: ssbi: fix function name typo
Message-ID: <6327573.Mj84IgUkQi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two newly added qcom ssbi pinctrl drivers have the same bug
from a function name that apparently got changed in one place
but not another, resulting in a build error when CONFIG_DEBUG_FS
is disabled:

drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c:652:14: error: 'pm8xxx_mpp_dbg_show' undeclared here (not in a function)

This fixes the two identifiers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b4c45fe974bc ("pinctrl: qcom: ssbi: Family A gpio & mpp drivers")

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index e1a3721bc8e5..d809c9eaa323 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -584,7 +584,7 @@ static void pm8xxx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 }
 
 #else
-#define msm_gpio_dbg_show NULL
+#define pm8xxx_gpio_dbg_show NULL
 #endif
 
 static struct gpio_chip pm8xxx_gpio_template = {
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 6652b8d7f707..8982027de8e8 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -639,7 +639,7 @@ static void pm8xxx_mpp_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 }
 
 #else
-#define msm_mpp_dbg_show NULL
+#define pm8xxx_mpp_dbg_show NULL
 #endif
 
 static struct gpio_chip pm8xxx_mpp_template = {
