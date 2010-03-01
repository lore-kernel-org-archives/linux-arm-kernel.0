From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  1 Mar 2010 19:57:59 +0000
Subject: [PATCH 2.6.34] ASoC: Fix S3C64xx IIS driver for Samsung header reorg
Message-ID: <1267473479-443-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reorgs of the Samsung headers have moved the GPIO bank definitions
from plat/ to mach/ - the IIS driver needs to be updated to take care
of this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Ideally this could also go in via the same path as the ARM/Samsung changes
which do the moves.  If those get merged without this fix then it may as
well go via ASoC.

 sound/soc/s3c24xx/s3c64xx-i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 93ed3aa..a72c251 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -22,8 +22,8 @@
 #include <sound/soc.h>
 
 #include <plat/regs-s3c2412-iis.h>
-#include <plat/gpio-bank-d.h>
-#include <plat/gpio-bank-e.h>
+#include <mach/gpio-bank-d.h>
+#include <mach/gpio-bank-e.h>
 #include <plat/gpio-cfg.h>
 
 #include <mach/map.h>
-- 
1.7.0
