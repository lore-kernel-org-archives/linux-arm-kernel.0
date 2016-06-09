From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu,  9 Jun 2016 13:06:38 +0100
Subject: [PATCH] ARM: mx25: fix missing common.h include
Message-ID: <1465473998-32261-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prototype for imx25_pm_init() was not in any of the included
headers, so add common.h where it is declared to remove the
following warning:

arch/arm/mach-imx/pm-imx25.c:34:13: warning: symbol 'imx25_pm_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/pm-imx25.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx25.c b/arch/arm/mach-imx/pm-imx25.c
index 8bba9fc..35aa082 100644
--- a/arch/arm/mach-imx/pm-imx25.c
+++ b/arch/arm/mach-imx/pm-imx25.c
@@ -10,6 +10,8 @@
 #include <linux/suspend.h>
 #include <linux/io.h>
 
+#include "common.h"
+
 static int imx25_suspend_enter(suspend_state_t state)
 {
 	if (!IS_ENABLED(CONFIG_PM))
-- 
2.8.1
