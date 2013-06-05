From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:00 +0900
Subject: [PATCH 009/130] sh-pfc: Remove dependency on GPIOLIB
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Make GPIO support optional for platforms that don't support GPIOLIB.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/Kconfig  | 2 --
 drivers/pinctrl/sh-pfc/core.h   | 1 +
 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 9f0217b..a0b6bd0 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -5,8 +5,6 @@
 if ARCH_SHMOBILE || SUPERH
 
 config PINCTRL_SH_PFC
-	# XXX move off the gpio dependency
-	depends on GPIOLIB
 	select GPIO_SH_PFC if ARCH_REQUIRE_GPIOLIB
 	select PINMUX
 	select PINCONF
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index ee4a4d6..6ec746f 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -11,6 +11,7 @@
 #define __SH_PFC_CORE_H__
 
 #include <linux/compiler.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 3b785fc..b170761 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -11,8 +11,8 @@
 #ifndef __SH_PFC_H
 #define __SH_PFC_H
 
+#include <linux/bug.h>
 #include <linux/stringify.h>
-#include <asm-generic/gpio.h>
 
 typedef unsigned short pinmux_enum_t;
 
-- 
1.8.2.1
