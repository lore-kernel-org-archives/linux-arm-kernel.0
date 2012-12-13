From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 13 Dec 2012 16:12:51 +0530
Subject: [PATCH V5 0/2]  Add DT support for i2s
Message-ID: <1355395373-22058-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V5 patches are based on Mark Brown's for-next branch of
"git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git"

Changes since V4:
	- Add a new patch for renaming the samsung i2s secondary fifo interface
	  device name from "samsung-i2s.4" to "samsung-i2s-sec"
	- Add platform_device_id table for the primary and secondary DAIs
	- Avoid using of alias ids in the i2s driver by adding of_device_id
	  table. Primary device can get registered via dt or non-dt but secondary
	  device can get registered only at runtime because the secondary is not
	  physically present on the board.

Changes since V3:
        - Added syntex of gpio specifier as suggested by Mark Brown in
          DT document file
        - Added the requirement for having I2S alias ids
        - Explained about gpio lines
        - Made a seperate patch to get the I2S rclk src clk from alias ID

Changes since V2:
        - Rebased on 3.7-rc3
        - Custom DT bindings are prefixed with samsung
        - As generic device tree DMA helpers not yet mainlined
          I am still using custom dma bindings. So added a
          priliminary statement regarding the same. I will rework
          on my patch once generic DMA helpers are mainlined.

Chnages since V1:
        - Rebased on 3.6-rc6

Padmavathi Venna (2):
  ASoC: Samsung: Rename samsung i2s secondary device name
  ASoC: SAMSUNG: Add DT support for i2s

 .../devicetree/bindings/sound/samsung-i2s.txt      |   75 ++++++
 sound/soc/samsung/dma.c                            |    1 +
 sound/soc/samsung/dma.h                            |    1 +
 sound/soc/samsung/i2s.c                            |  262 ++++++++++++++++----
 sound/soc/samsung/i2s.h                            |    7 -
 sound/soc/samsung/smdk_wm8580.c                    |    7 +-
 sound/soc/samsung/smdk_wm8994.c                    |    4 +-
 7 files changed, 300 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt

-- 
1.7.4.4
