From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:46 +0100
Subject: [PATCH 10/15] pinctrl: pinctrl-nomadik: Append sleepmode property
 with vendor specific prefixes
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any non-standard property should contain the vendor's identifier which
should be perpended onto the property name followed by a comma. This
aids in name-space collision prevention. This patch ensures the
sleepmode property adheres to the rules.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-nmk.txt          |    2 +-
 drivers/pinctrl/pinctrl-nomadik.c                  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
index ee87467..8315ac7 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
@@ -26,6 +26,6 @@ Example:
                         #gpio-cells = <2>;
                         gpio-controller;
                         interrupt-controller;
-                        supports-sleepmode;
+                        st,supports-sleepmode;
                         gpio-bank = <1>;
                 };
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index e297499..8ca100d 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1198,7 +1198,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 		if (!pdata)
 			return -ENOMEM;
 
-		if (of_get_property(np, "supports-sleepmode", NULL))
+		if (of_get_property(np, "st,supports-sleepmode", NULL))
 			pdata->supports_sleepmode = true;
 
 		if (of_property_read_u32(np, "gpio-bank", &dev->id)) {
-- 
1.7.9.5
