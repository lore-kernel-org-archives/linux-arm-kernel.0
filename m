From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Nov 2018 21:17:45 -0800
Subject: [PATCH v8 0/7] Add support for audiocodec in Allwinner A64
Message-ID: <20181121051752.18387-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: - Use simple-amplifier for speaker amp on Pinebook
    - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
      string for other 3 I2S modules in A64 in case if there's any
      incompatibility with H3
v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
    - use ilog2() to calculate reg value for LRCK div instead of using a
      table
v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
      define our board-level widgets instead.
v5: - collect all the tags
v6: - driver patches has been merged through ASoC tree
    - rebase onto 4.20-rc1
    - Drop 'Speaker' from routes on sopine and pine64, they don't have
      speaker.
v7: - drop 'Mic' and 'Headset Mic' from dtsi
    - move AIF1 Slot 0 ADC to ADC route to sun8i-codec
    - drop BIAS routes for Pine64 and SoPine
v8  - drop merged patches
    - add regulator property for simple amplifier, make enable-gpio
      optional
    - add regulator to speaker amp, introduce headphone amp


Vasily Khoruzhick (7):
  ASoC: dt-bindings: add regulator property to simple amplifier
  ASoC: simple-amplifier: add VCC regulator widget
  ASoC: dt-bindings: make enable-gpio optional for simple amplifier
  ASoC: simple-amplifier: make enable-gpio optional
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../bindings/sound/simple-amplifier.txt       |  5 ++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 35 ++++++++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 53 ++++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 35 ++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
 sound/soc/codecs/simple-amplifier.c           |  7 ++-
 6 files changed, 188 insertions(+), 1 deletion(-)

-- 
2.19.1
