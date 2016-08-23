From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 23 Aug 2016 18:17:46 +0100
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Message-ID: <20160823171746.16063-1-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
these if the appropriate SoC they're embedded in isn't enabled.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 sound/soc/sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 2a954bd..dd23682 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -1,4 +1,5 @@
 menu "Allwinner SoC Audio support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 
 config SND_SUN4I_CODEC
 	tristate "Allwinner A10 Codec Support"
-- 
2.9.3
