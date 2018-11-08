From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed,  7 Nov 2018 22:39:26 -0800
Subject: [PATCH v6 0/3] Add support for audiocodec in Allwinner A64
Message-ID: <20181108063929.29720-1-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables sound on Pine64, SoPine boards and Pinebook.

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

Vasily Khoruzhick (3):
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 28 +++++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 42 ++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 28 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 58 +++++++++++++++++++
 4 files changed, 156 insertions(+)

-- 
2.19.1
