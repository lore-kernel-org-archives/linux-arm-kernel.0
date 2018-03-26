From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 26 Mar 2018 15:05:34 -0400
Subject: [PATCH v3 4/4] drivers/staging: Remove fsl-mc driver from staging
In-Reply-To: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1522091134-24646-5-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the staging/drivers/fsl-mc directory from the staging
area now that all the components have been moved to the main
kernel areas.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/Kconfig             | 2 --
 drivers/staging/Makefile            | 1 -
 drivers/staging/fsl-mc/Kconfig      | 2 --
 drivers/staging/fsl-mc/Makefile     | 3 ---
 drivers/staging/fsl-mc/bus/Kconfig  | 7 -------
 drivers/staging/fsl-mc/bus/Makefile | 7 -------
 6 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d5926f0..a0f262a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -98,8 +98,6 @@ source "drivers/staging/clocking-wizard/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
 
-source "drivers/staging/fsl-mc/Kconfig"
-
 source "drivers/staging/fsl-dpaa2/Kconfig"
 
 source "drivers/staging/wilc1000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 919753c..326a1e8 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_CRYPTO_SKEIN)	+= skein/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
-obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
 obj-$(CONFIG_MOST)		+= most/
diff --git a/drivers/staging/fsl-mc/Kconfig b/drivers/staging/fsl-mc/Kconfig
deleted file mode 100644
index 3002229..0000000
--- a/drivers/staging/fsl-mc/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-source "drivers/staging/fsl-mc/bus/Kconfig"
diff --git a/drivers/staging/fsl-mc/Makefile b/drivers/staging/fsl-mc/Makefile
deleted file mode 100644
index 1468388..0000000
--- a/drivers/staging/fsl-mc/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Freescale Management Complex (MC) bus drivers
-obj-$(CONFIG_FSL_MC_BUS)	+= bus/
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
deleted file mode 100644
index 90f234d..0000000
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# DPAA2 fsl-mc bus
-#
-# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
-#
-
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
deleted file mode 100644
index 2141e4b..0000000
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Freescale Management Complex (MC) bus drivers
-#
-# Copyright (C) 2014 Freescale Semiconductor, Inc.
-#
-
-- 
2.7.4
