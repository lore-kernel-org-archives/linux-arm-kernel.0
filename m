From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:40 +0200
Subject: [PATCH 08/21] ASoC: ux500: forward declare msp_i2s_platform_data
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a lot of build warnings from the msp driver like:

In file included from sound/soc/ux500/ux500_msp_dai.h:21:0,
                 from sound/soc/ux500/mop500.c:25:
sound/soc/ux500/ux500_msp_i2s.h:546:11: warning: 'struct msp_i2s_platform_data' declared inside parameter list [enabled by default]
    struct msp_i2s_platform_data *platform_data);
           ^
sound/soc/ux500/ux500_msp_i2s.h:546:11: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

The easiest solution is to add a declaration of the struct name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel at alsa-project.org
---
 sound/soc/ux500/ux500_msp_i2s.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 1311c0d..6f3e3dc 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -543,6 +543,7 @@ struct ux500_msp_dma_params {
 	struct stedma40_chan_cfg *dma_cfg;
 };
 
+struct msp_i2s_platform_data;
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 			struct ux500_msp **msp_p,
 			struct msp_i2s_platform_data *platform_data);
-- 
1.8.1.2
