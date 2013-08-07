From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:15:19 +0530
Subject: [PATCH V3 0/3] Add audio support on smdk5420
Message-ID: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung has different versions of I2S introduced in different
platforms. Each version has some new support added for multichannel,
secondary fifo, s/w reset control, internal mux for rclk src clk and
tdm support. Each newly added change has a quirk. So this patch adds
all the required quirks as driver data and based on compatible string
from dtsi fetches the quirks. This also adds i2s support on exynos5420.

Changes since V2:
        - Seperated out driver side changes and dts changes in two
          patch sets.
        - Replaced samsung,s3c6410-i2s-v4 with samsung,s3c6410-i2s-multi
          for more clarity as suggested by Tomasz Figa.

Changes since V1:
        - Pass quirks as driver data and fetch the quirks based on
          compatible string from dtsi file as suggested by
          Tomasz Figa and Mark Brown
        - Make the I2S driver more flexible with respect to register
          access as suggested by Tomasz Figa and Mark Brown
        - Add 5420 support in the driver.
        - Modify the dtsi files with the corresponding compatible
          strings and removed the i2s quirks from 5250 dtsi file.
        - Updated the i2s Documentation with relevent changes and
          i2s versioning info.
        - Add i2s nodes on exynos5420.dtsi
        - Enable sound support on smdk5420

This patch set is made based on Mark Brown for-next branch on sound.git.

Padmavathi Venna (3):
  platform: Increase platform name size
  ASoC: Samsung: I2S: Add quirks as driver data in I2S
  ASoC: Samsung: I2S: Modify the I2S driver to support I2S on
    Exynos5420

 .../devicetree/bindings/sound/samsung-i2s.txt      |   25 ++--
 include/linux/mod_devicetable.h                    |    2 +-
 include/linux/platform_data/asoc-s3c.h             |    1 +
 sound/soc/samsung/i2s-regs.h                       |   15 ++
 sound/soc/samsung/i2s.c                            |  163 +++++++++++++++-----
 5 files changed, 158 insertions(+), 48 deletions(-)

-- 
1.7.4.4
