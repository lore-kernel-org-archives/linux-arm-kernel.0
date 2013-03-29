From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:39 +0800
Subject: [PATCH 03/13] ASoC: mxs-saif: remove mach header inclusion
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header <mach/hardware.h> is not needed at all, and <mach/mxs.h> is
needed only for macros MXS_SET_ADDR and MXS_CLR_ADDR.  Define the macros
and remove the mach header inclusions.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/mxs/mxs-saif.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 3a2aa1d..41a6136 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -33,11 +33,12 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <mach/mxs.h>
 
 #include "mxs-saif.h"
 
+#define MXS_SET_ADDR	0x4
+#define MXS_CLR_ADDR	0x8
+
 static struct mxs_saif *mxs_saif[2];
 
 /*
-- 
1.7.9.5
