From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:32:59 +0800
Subject: [PATCH V2 00/11] enable imx6q_sabrelite sgtl5000 audio support
Message-ID: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:

 - rebase to latest clk and pinctrl base
 - fix according v1 comments.

You can also get at:
https://github.com/riczhao/kernel-imx/tree/topics/audio

Richard Zhao (11):
  dma: imx-sdma: make channel0 operations atomic
  ARM: dts: imx6q-sabrelite: add i2c1 pinctrl support
  ASoC: imx-audmux: add pinctrl support
  ARM: dts: imx6q-sabrelite: add audmux pinctrl support
  ARM: imx6q: add ssi1_ipg clk_lookup
  ASoC: fsl_ssi: convert to use devm_clk_get
  ARM: imx6q_sabrelite: clk_register_clkdev cko1 for sgtl5000
  ARM: dts: imx6q-sabrelite: add sound device imx6q-sabrelite-sgtl5000
  ARM: dts: imx6q-sabrelite: add serial2 pinctrl support
  ARM: imx6q: change clkdev device name from xxxx.uart to xxxx.serial
  ARM: imx6q: change clkdev device name from xxxx.enet to xxxx.ethernet

 arch/arm/boot/dts/imx6q-sabrelite.dts |   20 +++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   23 +++++++++++++
 arch/arm/mach-imx/clk-imx6q.c         |   35 +++++++++++---------
 arch/arm/mach-imx/mach-imx6q.c        |   28 ++++++++++++++++
 drivers/dma/imx-sdma.c                |   57 ++++++++++++++++++---------------
 sound/soc/fsl/fsl_ssi.c               |    7 +---
 sound/soc/fsl/imx-audmux.c            |    8 +++++
 7 files changed, 132 insertions(+), 46 deletions(-)

-- 
1.7.5.4
