From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 May 2012 11:44:22 +0200
Subject: [PATCH 01/12] gpio: move the Nomadik GPIO driver to pinctrl
Message-ID: <1336470262-23483-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

I'm moving this driver over to the pinctrl subsystem to convert
the custom pin mux/config scheme over to use pinctrl.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Makefile                              |    1 -
 drivers/pinctrl/Makefile                           |    1 +
 .../gpio-nomadik.c => pinctrl/pinctrl-nomadik.c}   |    0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/{gpio/gpio-nomadik.c => pinctrl/pinctrl-nomadik.c} (100%)

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 007f54b..a4193ab 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_GPIO_MSM_V1)	+= gpio-msm-v1.o
 obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
-obj-$(CONFIG_PLAT_NOMADIK)	+= gpio-nomadik.o
 obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
 obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 6d4150b..274e069 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PINCONF)		+= pinconf.o
 obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
 obj-$(CONFIG_PINCTRL_PXA3xx)	+= pinctrl-pxa3xx.o
 obj-$(CONFIG_PINCTRL_MMP2)	+= pinctrl-mmp2.o
+obj-$(CONFIG_PLAT_NOMADIK)	+= pinctrl-nomadik.o
 obj-$(CONFIG_PINCTRL_PXA168)	+= pinctrl-pxa168.o
 obj-$(CONFIG_PINCTRL_PXA910)	+= pinctrl-pxa910.o
 obj-$(CONFIG_PINCTRL_SIRF)	+= pinctrl-sirf.o
diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
similarity index 100%
rename from drivers/gpio/gpio-nomadik.c
rename to drivers/pinctrl/pinctrl-nomadik.c
-- 
1.7.9.2
