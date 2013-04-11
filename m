From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Thu, 11 Apr 2013 21:02:43 +0200
Subject: [PATCH] ASoC: samsung: fix neo1973-wm8753 compilation
In-Reply-To: <20130411171938.GS9243@opensource.wolfsonmicro.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <201304111908.42532.arnd@arndb.de>
 <20130411171938.GS9243@opensource.wolfsonmicro.com>
Message-ID: <201304112102.43896.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b2ca78717cea (ARM: S3C24XX: make gta02.h local) already replaced
the GTA02_GPIO_* constants in neo1973-wm8753.c but forgot to remove the
inclusion of mach/gta02.h before moving the file out of mach/.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 sound/soc/samsung/neo1973_wm8753.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index a301d8c..68675dd 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 #include <plat/regs-iis.h>
-#include <mach/gta02.h>
 
 #include "../codecs/wm8753.h"
 #include "s3c24xx-i2s.h"
-- 
1.7.2.3
