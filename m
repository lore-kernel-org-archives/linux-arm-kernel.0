From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun,  3 Dec 2017 12:41:48 -0800
Subject: [PATCH 0/9] Add audiocodec support for A64 SoC
Message-ID: <20171203204157.20829-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds A64 audiocodec support into sun4i-i2s, sun8i-codec
and sun8i-codec-analog drivers and enables sound on Pine64 and SoPine
boards.

Marcus Cooper (3):
  ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
  ASoC: sun8i-codec-analog: Use callbacks to add headphones and lineout
    outputs
  ASoC: sun8i-codec-analog: Add support for A64 SoC

Vasily Khoruzhick (6):
  ASoC: sun4i-i2s: Add quirk to handle fixed WSS
  ASoC: sun8i-codec: Add quirk to specify aif1_lrck_div value
  ASoC: sun8i-codec: Add support for A64 SoC
  ASoC: sun8i-codec-analog: Add component driver field to quirks
    structure
  arm64: dts: allwinner: a64: Add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: Enable sound on Pine64 and SoPine

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 .../sound/{sun8i-a33-codec.txt => sun8i-codec.txt} |   6 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  16 ++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  16 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  52 ++++
 sound/soc/sunxi/Kconfig                            |   2 +-
 sound/soc/sunxi/sun4i-i2s.c                        |  53 +++-
 sound/soc/sunxi/sun8i-codec-analog.c               | 307 ++++++++++++++++++---
 sound/soc/sunxi/sun8i-codec.c                      |  47 +++-
 10 files changed, 458 insertions(+), 44 deletions(-)
 rename Documentation/devicetree/bindings/sound/{sun8i-a33-codec.txt => sun8i-codec.txt} (91%)

-- 
2.15.0
