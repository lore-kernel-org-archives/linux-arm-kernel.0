From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 22 Jan 2012 14:57:25 -0500
Subject: [PATCH] arm: fix compile failure in mach-shmobile/board-ag5evm.c
Message-ID: <1327262245-21049-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add videodev2 header which provides V4L2_PIX_FMT_RGB565 to fix:

arch/arm/mach-shmobile/board-ag5evm.c:274: error: 'V4L2_PIX_FMT_RGB565' undeclared here (not in a function)

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index eff8a96..0ac36de 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -30,6 +30,7 @@
 #include <linux/serial_sci.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
+#include <linux/videodev2.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mmc/host.h>
-- 
1.7.7.2
