From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 25 Sep 2017 15:55:56 -0300
Subject: [PATCH 1/4] ARM: imx: imx31moboard: Include "board-mx31moboard.h"
 header file
Message-ID: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warnings are seen with W=1:

warning: no previous prototype for ?mx31moboard_devboard_init? 
[-Wmissing-prototypes] void __init mx31moboard_devboard_init(void)
warning: no previous prototype for ?mx31moboard_marxbot_init? 
[-Wmissing-prototypes] void __init mx31moboard_marxbot_init(void)

Fix these warnings by including "board-mx31moboard.h".

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/mach-imx/mx31moboard-devboard.c | 1 +
 arch/arm/mach-imx/mx31moboard-marxbot.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 1e91a09..3c224f4 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -22,6 +22,7 @@
 
 #include <linux/usb/otg.h>
 
+#include "board-mx31moboard.h"
 #include "common.h"
 #include "devices-imx31.h"
 #include "ehci.h"
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index 922d491..9a5a869 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -24,6 +24,7 @@
 
 #include <linux/usb/otg.h>
 
+#include "board-mx31moboard.h"
 #include "common.h"
 #include "devices-imx31.h"
 #include "ehci.h"
-- 
2.7.4
