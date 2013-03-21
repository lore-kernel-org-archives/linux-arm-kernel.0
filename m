From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 22:51:09 +0100
Subject: [PATCH 4/9] ARM: ux500: kill mach/hardware.h some more
In-Reply-To: <1363902674-6456-1-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
Message-ID: <1363902674-6456-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of ux500 specific drivers include mach/hardware.h
without actually needing it. Let's remove all remaining instances.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/ux500/cryp/cryp.c      | 2 --
 drivers/crypto/ux500/cryp/cryp_core.c | 1 -
 drivers/crypto/ux500/hash/hash_core.c | 1 -
 sound/soc/ux500/mop500_ab8500.c       | 2 --
 sound/soc/ux500/ux500_msp_dai.c       | 1 -
 sound/soc/ux500/ux500_msp_i2s.c       | 1 -
 6 files changed, 8 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp.c b/drivers/crypto/ux500/cryp/cryp.c
index e208cea..3eafa90 100644
--- a/drivers/crypto/ux500/cryp/cryp.c
+++ b/drivers/crypto/ux500/cryp/cryp.c
@@ -12,8 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-#include <mach/hardware.h>
-
 #include "cryp_p.h"
 #include "cryp.h"
 
diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 22c9063..32f4806 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -32,7 +32,6 @@
 #include <crypto/scatterwalk.h>
 
 #include <linux/platform_data/crypto-ux500.h>
-#include <mach/hardware.h>
 
 #include "cryp_p.h"
 #include "cryp.h"
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 632c333..1827e9f 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -32,7 +32,6 @@
 #include <crypto/algapi.h>
 
 #include <linux/platform_data/crypto-ux500.h>
-#include <mach/hardware.h>
 
 #include "hash_alg.h"
 
diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 78cce23..892ad9a 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -17,8 +17,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 
-#include <mach/hardware.h>
-
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 1e671f4..1551460 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -20,7 +20,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/dbx500-prcmu.h>
 
-#include <mach/hardware.h>
 #include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 124a78a..78fc26a 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <mach/hardware.h>
 #include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
-- 
1.8.1.2
