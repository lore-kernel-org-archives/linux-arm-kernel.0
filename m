From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 06 Sep 2011 19:25:16 +0530
Subject: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
	option
In-Reply-To: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung keyboard driver could be used with platforms using device tree.
So the inclusion of samsung keyboard driver cannot be based on
SAMSUNG_DEV_KEYPAD. A new config option HAVE_SAMSUNG_KEYPAD is added
which device tree based platforms should use to include samsung keyboard
driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/input/keyboard/Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b4dee9d..370fb18 100644
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
