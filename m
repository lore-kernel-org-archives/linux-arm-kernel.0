From: cjb@laptop.org (Chris Ball)
Date: Tue, 02 Oct 2012 15:03:21 -0400
Subject: [PATCH] ARM: pxa: Fix build error caused by sram.h rename
In-Reply-To: <1347368390-31252-7-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Tue, 11 Sep 2012 14:59:41 +0200")
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <87fw5wofwm.fsf_-_@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 293b2da1b61 ("ARM: pxa: move platform_data definitions")
renamed arch/arm/mach-mmp/include/mach/sram.h to
include/linux/platform_data/dma-mmp_tdma.h, but didn't update
mmp-pcm.c which uses the header.  Fix the build error.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 sound/soc/pxa/mmp-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 73ac546..e834faf 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -15,13 +15,13 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/platform_data/dma-mmp_tdma.h>
 #include <linux/platform_data/mmp_audio.h>
 #include <sound/pxa2xx-lib.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <mach/sram.h>
 #include <sound/dmaengine_pcm.h>
 
 struct mmp_dma_data {
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
