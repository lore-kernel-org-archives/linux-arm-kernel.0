From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 13:13:01 +0100
Subject: [PATCH] ASoC: AMD: add missing include
Message-ID: <4595844.NIUnxKiA0y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added AMD acp driver is missing an include for linux/io.h
and fails to build on ARM:

sound/soc/amd/acp-pcm-dma.c: In function 'acp_reg_read':
sound/soc/amd/acp-pcm-dma.c:83:9: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]

This adds the missing line.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This build error also appeared today on linux-next with ARM randconfig

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cc8b841b69b6..fa0311e4faed 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
+#include <linux/io.h>
 
 #include <sound/soc.h>
 
