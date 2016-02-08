From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon,  8 Feb 2016 18:57:38 +0100
Subject: [PATCH 1/2] pinctrl: stm32: Remove dependency with DT bindings header
 files
In-Reply-To: <1454954259-4923-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454954259-4923-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1454954259-4923-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some macros where defined in DT bindings headers, whereas only used
in the driver.

This patch moves these macros to the driver side.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 2 --
 drivers/pinctrl/stm32/pinctrl-stm32.h | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 9a08222..8deb566 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -23,8 +23,6 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/pinctrl/pinctrl-stm32.h>
-
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinctrl-utils.h"
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index 1b7c369..35ebc94 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -9,6 +9,14 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
+#define STM32_PIN_NO(x) ((x) << 8)
+#define STM32_GET_PIN_NO(x) ((x) >> 8)
+#define STM32_GET_PIN_FUNC(x) ((x) & 0xff)
+
+#define STM32_PIN_GPIO		0
+#define STM32_PIN_AF(x)		((x) + 1)
+#define STM32_PIN_ANALOG	(STM32_PIN_AF(15) + 1)
+
 struct stm32_desc_function {
 	const char *name;
 	const unsigned char num;
-- 
1.9.1
