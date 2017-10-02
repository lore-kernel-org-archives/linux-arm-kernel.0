From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:43 +0200
Subject: [PATCH v3 01/12] pinctrl: move gpio-axp209 to pinctrl
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare the driver for the upcoming pinctrl features, move the GPIO
driver AXP209 from GPIO to pinctrl subsystem.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 .../bindings/{gpio/gpio-axp209.txt => pinctrl/pinctrl-axp209.txt}   | 0
 drivers/gpio/Kconfig                                                | 6 ------
 drivers/gpio/Makefile                                               | 1 -
 drivers/pinctrl/Kconfig                                             | 6 ++++++
 drivers/pinctrl/Makefile                                            | 1 +
 drivers/{gpio/gpio-axp209.c => pinctrl/pinctrl-axp209.c}            | 0
 6 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/{gpio/gpio-axp209.txt => pinctrl/pinctrl-axp209.txt} (100%)
 rename drivers/{gpio/gpio-axp209.c => pinctrl/pinctrl-axp209.c} (100%)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
similarity index 100%
rename from Documentation/devicetree/bindings/gpio/gpio-axp209.txt
rename to Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 796b11c489ae..aae33f7d82ef 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -122,12 +122,6 @@ config GPIO_ATH79
 	  Select this option to enable GPIO driver for
 	  Atheros AR71XX/AR724X/AR913X SoC devices.
 
-config GPIO_AXP209
-	tristate "X-Powers AXP209 PMIC GPIO Support"
-	depends on MFD_AXP20X
-	help
-	  Say yes to enable GPIO support for the AXP209 PMIC
-
 config GPIO_BCM_KONA
 	bool "Broadcom Kona GPIO"
 	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index aeb70e9de6f2..f63631a63b09 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_GPIO_AMDPT)	+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
-obj-$(CONFIG_GPIO_AXP209)	+= gpio-axp209.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 82cd8b08d71f..acda2e29167c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -63,6 +63,12 @@ config PINCTRL_AS3722
 	  open drain configuration for the GPIO pins of AS3722 devices. It also
 	  supports the GPIO functionality through gpiolib.
 
+config PINCTRL_AXP209
+	tristate "X-Powers AXP209 PMIC pinctrl and GPIO Support"
+	depends on MFD_AXP20X
+	help
+	  Say yes to enable pinctrl and GPIO support for the AXP209 PMIC
+
 config PINCTRL_BF54x
 	def_bool y if BF54x
 	select PINCTRL_ADI2
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index c16e27900dbb..9f621e542f59 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
 obj-$(CONFIG_PINCTRL_ADI2)	+= pinctrl-adi2.o
 obj-$(CONFIG_PINCTRL_ARTPEC6)	+= pinctrl-artpec6.o
 obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
+obj-$(CONFIG_PINCTRL_AXP209)	+= pinctrl-axp209.o
 obj-$(CONFIG_PINCTRL_BF54x)	+= pinctrl-adi2-bf54x.o
 obj-$(CONFIG_PINCTRL_BF60x)	+= pinctrl-adi2-bf60x.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
diff --git a/drivers/gpio/gpio-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
similarity index 100%
rename from drivers/gpio/gpio-axp209.c
rename to drivers/pinctrl/pinctrl-axp209.c
-- 
2.11.0
