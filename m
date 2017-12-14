From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 12:23:47 +0800
Subject: [PATCH v2 0/3] ARM: sun8i: a83t: Add support for I2S and I2C
Message-ID: <20171214042350.29469-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of my A83T I2S and I2C support series.

Changes since v1:

  - Dropped ASoC patch that was merged
  - Added SoC-specific compatible strings for I2C controllers
  - Added Maxime's Acked-by

This series adds support for I2S and I2C on the Allwinner A83T SoC.
The I2S controllers are similar to the ones found on the A31. However
the TX FIFO and interrupt status registers were swapped around. This
seems to be a recurring theme for the audio related hardware blocks.

Patch 1 adds device nodes and default pinmux settings for the I2S
controllers.

Patch 2 adds device nodes and default pinmux settings for the I2C
controllers.

Patch 3 is an example of a PCM5122 codec tied to I2C2 and I2S1 over
the GPIO header of the Banana Pi M3. This patch should not be merged.

Please have a look.

Regards
ChenYu

Chen-Yu Tsai (3):
  ARM: dts: sun8i: a83t: Add I2S controller device nodes
  ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings
  [DO NOT MERGE] ARM: dts: sun8i: a83t: bpi-m3: Enable PCM5122 codec
    with I2S1

 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts |  33 +++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi            | 102 +++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

-- 
2.15.0
