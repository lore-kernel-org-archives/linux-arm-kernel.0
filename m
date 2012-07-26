From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 11:28:38 +0100
Subject: [PATCH 05/21] ASoC: ux500: Include the correct header files
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343298534-13611-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thought to be another merge error, board-mop500-msp.h has never existed
in the upstream kernel, only msp.h. This patch changes the include files
to match the existing file name.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_msp_dai.c |    2 +-
 sound/soc/ux500/ux500_msp_i2s.c |    2 +-
 sound/soc/ux500/ux500_msp_i2s.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index cdbbdaf..772cb19 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -21,7 +21,7 @@
 #include <linux/mfd/dbx500-prcmu.h>
 
 #include <mach/hardware.h>
-#include <mach/board-mop500-msp.h>
+#include <mach/msp.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 4c79850..36be11e 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -19,7 +19,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>
-#include <mach/board-mop500-msp.h>
+#include <mach/msp.h>
 
 #include <sound/soc.h>
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 7f71b4a..2d9136d 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -17,7 +17,7 @@
 
 #include <linux/platform_device.h>
 
-#include <mach/board-mop500-msp.h>
+#include <mach/msp.h>
 
 #define MSP_INPUT_FREQ_APB 48000000
 
-- 
1.7.9.5
