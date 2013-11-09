From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:33:49 +0100
Subject: [PATCH 2/2] ASoC: sh: rcar: Depend on ARCH_SHMOBILE_LEGACY
In-Reply-To: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1384000429-3590-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't compile on multiplatform kernels as it requires
<mach/clock.h>.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 sound/soc/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 56d8ff6..ce7cfd6 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_SH4_SIU
 
 config SND_SOC_RCAR
 	tristate "R-Car series SRU/SCU/SSIU/SSI support"
+	depends on ARCH_SHMOBILE_LEGACY
 	select SND_SIMPLE_CARD
 	select RCAR_CLK_ADG
 	help
-- 
1.8.1.5
