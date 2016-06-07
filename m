From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 18:33:06 +0100
Subject: [PATCH] pinctrl: sh-pfc: fix warnings by include core.h
Message-ID: <1465320786-10333-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warnings about emev2_pinmux_info and r8a7779_pinmux_info
by using core.h instead of sh_pfc.h in these files. This gives
the declarations of the two structures and removes the following
warnings:

drivers/pinctrl/sh-pfc/pfc-emev2.c:1695:30: warning: symbol 'emev2_pinmux_info' was not declared. Should it be static?
drivers/pinctrl/sh-pfc/pfc-r8a7779.c:3888:30: warning: symbol 'r8a7779_pinmux_info' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-gpio at vger.kernel.org
---
 drivers/pinctrl/sh-pfc/pfc-emev2.c   | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-emev2.c b/drivers/pinctrl/sh-pfc/pfc-emev2.c
index 1cbbe04..f943854 100644
--- a/drivers/pinctrl/sh-pfc/pfc-emev2.c
+++ b/drivers/pinctrl/sh-pfc/pfc-emev2.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 
-#include "sh_pfc.h"
+#include "core.h"
 
 #define CPU_ALL_PORT(fn, pfx, sfx)					\
 	PORT_10(0,  fn, pfx, sfx),	PORT_90(0,  fn, pfx, sfx),	\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 5bef934..098d01e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -21,7 +21,7 @@
 
 #include <linux/kernel.h>
 
-#include "sh_pfc.h"
+#include "core.h"
 
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
-- 
2.8.1
