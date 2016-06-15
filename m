From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jun 2016 23:11:19 +0200
Subject: [PATCH v2 0/4] ASoC: sunxi: Add i2s controller support
Message-ID: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is the second version of the I2S support for the controller found
in the Allwinner A10 and later SoCs.

Playback has been tested with an UDA1380 on an A20-Olinuxino. Capture
is not implemented yet, but will come eventually.

Let me know what you think,
Maxime

Changes from v1:
  - Fixed bogus indentation and spurious whitespaces / newlines
  - Moved the device initialisation in the probe to the startup function
  - Disabled the device in shutdown
  - Removed function to get wss and sr to inline them in hw_params
  - Changed the way to access the divider array
  - Checked clk_set_rate return code
  - Fixed condition for invalid bclk and mclk dividers
  - Added sound-dai-cells to the bindings documentation required properties

Emilio L?pez (1):
  ARM: sun7i: Add mod1 clock nodes

Maxime Ripard (3):
  ASoC: sunxi: Add A10 I2S controller binding documentation
  ASoC: sunxi: Add Allwinner A10 Digital Audio driver
  ARM: sun7i: Add DAI nodes

 .../devicetree/bindings/sound/sun4i-i2s.txt        |  34 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  87 ++-
 sound/soc/sunxi/Kconfig                            |   9 +
 sound/soc/sunxi/Makefile                           |   2 +-
 sound/soc/sunxi/sun4i-i2s.c                        | 703 +++++++++++++++++++++
 5 files changed, 832 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt
 create mode 100644 sound/soc/sunxi/sun4i-i2s.c

-- 
2.9.0
