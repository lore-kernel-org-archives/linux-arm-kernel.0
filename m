From: alexanders83@web.de (Alexander Stein)
Date: Fri, 20 Mar 2015 20:12:01 +0100
Subject: [PATCH 2/2] pinctrl: at91: Add missing include
In-Reply-To: <1426878721-2618-1-git-send-email-alexanders83@web.de>
References: <1426878721-2618-1-git-send-email-alexanders83@web.de>
Message-ID: <1426878721-2618-2-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the sparse warning:
drivers/pinctrl/pinctrl-at91.c:1556:6: warning: symbol
 'at91_pinctrl_gpio_suspend' was not declared. Should it be static?
drivers/pinctrl/pinctrl-at91.c:1580:6: warning: symbol
 'at91_pinctrl_gpio_resume' was not declared. Should it be static?

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 drivers/pinctrl/pinctrl-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index a882523..02f6477 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -25,6 +25,8 @@
 /* Since we request GPIOs from ourself */
 #include <linux/pinctrl/consumer.h>
 
+#include <mach/hardware.h>
+
 #include "pinctrl-at91.h"
 #include "core.h"
 
-- 
2.3.3
