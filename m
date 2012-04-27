From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 15:02:54 +0800
Subject: [PATCH 00/11] enable imx6q_sabrelite sgtl5000 audio support
Message-ID: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's based on Dong Aisheng's early pinctrl patch and Sascha's v2
convert to common clk patch.

You can also get at:
https://github.com/riczhao/kernel-imx/tree/topics/audio

Richard Zhao (11):
  dma: imx-sdma: make channel0 operations atomic
  ASoC: imx-sgtl5000: add of_node_put when probe fail.
  ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000
  i2c: imx: add pinctrl support
  ARM: imx6q: move imx6q_sabrelite specific code to a dedicated
    function
  ARM: dts: imx6q-sabrelite: add ssi device
  ARM: dts: imx6q-sabrelite: add audmux device
  ASoC: imx-audmux: add pinctrl support
  ARM: imx6q: add ssi1 clk_lookup
  ARM: imx6q_sabrelite: clkdev_add cko1 for sgtl5000
  ARM: dts: imx6q-sabrelite: add sound device imx6q-sabrelite-sgtl5000

 arch/arm/boot/dts/imx6q-sabrelite.dts |   30 ++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   46 +++++++++++++++++++++++--
 arch/arm/mach-imx/clk-imx6q.c         |    4 ++
 arch/arm/mach-imx/mach-imx6q.c        |   37 +++++++++++++++++++-
 drivers/dma/imx-sdma.c                |   57 ++++++++++++++++++-------------
 drivers/i2c/busses/i2c-imx.c          |    9 +++++
 sound/soc/fsl/imx-audmux.c            |    8 ++++
 sound/soc/fsl/imx-sgtl5000.c          |   61 +++++++++++++++++++++++++--------
 8 files changed, 208 insertions(+), 44 deletions(-)

Thanks
Richard
-- 
1.7.5.4
