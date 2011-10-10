From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 21:59:56 +0530
Subject: [PATCH v5 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
	option
In-Reply-To: <1318264197-6698-1-git-send-email-thomas.abraham@linaro.org>
References: <1318264197-6698-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1318264197-6698-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For platforms using device tree, the static keypad device instances
are not required and SAMSUNG_DEV_KEYPAD is not selected. Since,
samsung keypad driver has dependency on SAMSUNG_DEV_KEYPAD config
option, the driver is left out of the compilation for dt enabled
platforms.

An additional config option 'HAVE_SAMSUNG_KEYPAD' is added
which the device tree based platforms can select. This config
option is added as an alternative dependency for keypad driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/input/keyboard/Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b4dee9d..7c322a3 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -423,9 +423,16 @@ config KEYBOARD_PMIC8XXX
 	  To compile this driver as a module, choose M here: the module will
 	  be called pmic8xxx-keypad.
 
+config HAVE_SAMSUNG_KEYPAD
+	bool
+	help
+	  This will include Samsung Keypad controller driver support. If you
+	  want to include Samsung Keypad support for any machine, kindly
+	  select this in the respective mach-xxxx/Kconfig file.
+
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
-	depends on SAMSUNG_DEV_KEYPAD
+	depends on SAMSUNG_DEV_KEYPAD || HAVE_SAMSUNG_KEYPAD
 	help
 	  Say Y here if you want to use the Samsung keypad.
 
-- 
1.6.6.rc2
