From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Mar 2014 09:49 +0100
Subject: Qualcomm PMIC8XXX keypad never worked?
Message-ID: <5887114.1jrNo21sGX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Something in the MFD_PM8XXX driver must have changed recently that now allows
the KEYBOARD_PMIC8XXX driver to be enabled. Unfortunately, it does not build
because of a dependency on the <linux/mfd/pm8xxx/gpio.h> header file that
does not exist.

In order to keep 'make randconfig' working on my test box, I have disabled
this driver, but it would be nice of someone could have a look into fixing it.

	Arnd

--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -470,7 +470,7 @@ config KEYBOARD_PXA930_ROTARY
 
 config KEYBOARD_PMIC8XXX
        tristate "Qualcomm PMIC8XXX keypad support"
-       depends on MFD_PM8XXX
+       depends on MFD_PM8XXX && BROKEN
        select INPUT_MATRIXKMAP
        help
          Say Y here if you want to enable the driver for the PMIC8XXX
