From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 12 Dec 2017 16:11:44 +0800
Subject: [PATCH 0/4] ARM: sun8i: a83t: Add support for I2S and I2C
Message-ID: <20171212081148.9194-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for I2S and I2C on the Allwinner A83T SoC.
The I2S controllers are similar to the ones found on the A31. However
the TX FIFO and interrupt status registers were swapped around. This
seems to be a recurring theme for the audio related hardware blocks.

Patch 1 adds support for the A83T variant with a compatible string
and associated quirks structure.

Patch 2 adds device nodes and default pinmux settings for the I2S
controllers.

Patch 3 adds device nodes and default pinmux settings for the I2C
controllers.

Patch 4 is an example of a PCM5122 codec tied to I2C2 and I2S1 over
the GPIO header of the Banana Pi M3. This patch should not be merged.

Please have a look.

Regards
ChenYu


Chen-Yu Tsai (4):
  ASoC: sun4i-i2s: Add support for A83T
  ARM: dts: sun8i: a83t: Add I2S controller device nodes
  ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings
  [DO NOT MERGE] ARM: dts: sun8i: a83t: bpi-m3: Enable PCM5122 codec
    with I2S1

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  2 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       | 33 ++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 99 ++++++++++++++++++++++
 sound/soc/sunxi/sun4i-i2s.c                        | 21 +++++
 4 files changed, 155 insertions(+)

-- 
2.15.0
