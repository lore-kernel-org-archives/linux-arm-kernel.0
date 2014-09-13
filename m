From: jay.xu@rock-chips.com (Jianqun)
Date: Sat, 13 Sep 2014 08:40:19 +0800
Subject: [PATCH 1/5] ASoC: rockchip-i2s: fix rockchip i2s defination more
 reasonable
In-Reply-To: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1410568819-21671-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix SND_ROCKCHIP_I2S to be more reasonable - SND_SOC_ROCKCHIP_I2S,
SND_SOC_ROCKCHIP_I2S should select by audio driver, instead of
SND_SOC_ROCKCHIP.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/Kconfig  | 3 +--
 sound/soc/rockchip/Makefile | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index c196a46..78fc159 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -2,11 +2,10 @@ config SND_SOC_ROCKCHIP
 	tristate "ASoC support for Rockchip"
 	depends on COMPILE_TEST || ARCH_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
-	select SND_ROCKCHIP_I2S
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Rockchip SoCs' Audio interfaces. You will also need to
 	  select the audio interfaces to support below.
 
-config SND_ROCKCHIP_I2S
+config SND_SOC_ROCKCHIP_I2S
 	tristate
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 1006418..b921909 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,4 +1,4 @@
 # ROCKCHIP Platform Support
 snd-soc-i2s-objs := rockchip_i2s.o
 
-obj-$(CONFIG_SND_ROCKCHIP_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
-- 
1.9.1
