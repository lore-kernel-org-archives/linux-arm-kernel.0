From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 20:59:03 +0200
Subject: [PATCH 2/8] sound: kirkwood: move <plat/audio.h> to
 <linux/platform_data/kirkwood-audio.h>
In-Reply-To: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346180349-25123-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346180349-25123-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/common.c              |    2 +-
 arch/arm/plat-orion/include/plat/audio.h     |    7 -------
 include/linux/platform_data/kirkwood-audio.h |    7 +++++++
 sound/soc/kirkwood/kirkwood-i2s.c            |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)
 delete mode 100644 arch/arm/plat-orion/include/plat/audio.h
 create mode 100644 include/linux/platform_data/kirkwood-audio.h

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index c4b64ad..138ba47 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -18,6 +18,7 @@
 #include <linux/clk-provider.h>
 #include <linux/spinlock.h>
 #include <linux/mv643xx_i2c.h>
+#include <linux/platform_data/kirkwood-audio.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -26,7 +27,6 @@
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include <plat/audio.h>
 #include <plat/cache-feroceon-l2.h>
 #include <plat/mvsdio.h>
 #include <plat/orion_nand.h>
diff --git a/arch/arm/plat-orion/include/plat/audio.h b/arch/arm/plat-orion/include/plat/audio.h
deleted file mode 100644
index d6a55bd..0000000
--- a/arch/arm/plat-orion/include/plat/audio.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __PLAT_AUDIO_H
-#define __PLAT_AUDIO_H
-
-struct kirkwood_asoc_platform_data {
-	int burst;
-};
-#endif
diff --git a/include/linux/platform_data/kirkwood-audio.h b/include/linux/platform_data/kirkwood-audio.h
new file mode 100644
index 0000000..a2c25da
--- /dev/null
+++ b/include/linux/platform_data/kirkwood-audio.h
@@ -0,0 +1,7 @@
+#ifndef __KIRKWOOD_AUDIO_PDATA_H
+#define __KIRKWOOD_AUDIO_PDATA_H
+
+struct kirkwood_asoc_platform_data {
+	int burst;
+};
+#endif
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 7646dd7..c4dd2f1 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -21,7 +21,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <plat/audio.h>
+#include <linux/platform_data/kirkwood-audio.h>
 #include "kirkwood.h"
 
 #define DRV_NAME	"kirkwood-i2s"
-- 
1.7.9.5
