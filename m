From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:09:27 +0200
Subject: [PATCH 2/3] sh-pfc: sh7372: Replace <mach/irqs.h> with
 <linux/sh_intc.h>
In-Reply-To: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671368-4681-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/irqs.h header is included only to get the evt2irq macro
definition. The macro is defined in linux/sh_intc.h, include it directly
instead of the mach-specific header.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 1528693..5a0b445 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -23,8 +23,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
-
-#include <mach/irqs.h>
+#include <linux/sh_intc.h>
 
 #include "core.h"
 #include "sh_pfc.h"
-- 
1.8.1.5
