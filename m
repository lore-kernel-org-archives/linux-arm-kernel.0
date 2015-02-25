From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Feb 2015 22:53:30 +0800
Subject: [PATCH 0/8] Fix struct clk pointer comparing
Message-ID: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the first day back from Chinese new year holiday, I got a regression
report from rmk, saying Ethernet stops working on HimmingBoard with
v4.0-rc1.

I read through the thread [1] and found a couple of i.MX audio drivers
are also affected per Stephen's Coccinelle report.  That's why I came up
with this series based on Quentin's structclk.cocci, Stephen's result
and Mike's input (thanks all).

The first two patches are run-time tested and all others are
compile-tested only.

[1] http://thread.gmane.org/gmane.linux.kernel/1872604/focus=1880862

Shawn Guo (8):
  clk: add helper function clk_is_match()
  ARM: imx: fix struct clk pointer comparing
  drm: armada: fix struct clk pointer comparing
  pwm: atmel-hlcdc: fix struct clk pointer comparing
  serial: samsung: fix struct clk pointer comparing
  ASoC: fsl_esai: fix struct clk pointer comparing
  ASoC: fsl_spdif: fix struct clk pointer comparing
  ASoC: kirkwood: fix struct clk pointer comparing

 arch/arm/mach-imx/mach-imx6q.c      |  5 +++--
 drivers/clk/clk.c                   |  6 ++++++
 drivers/gpu/drm/armada/armada_510.c |  2 +-
 drivers/pwm/pwm-atmel-hlcdc.c       |  2 +-
 drivers/tty/serial/samsung.c        |  2 +-
 include/linux/clk.h                 | 16 ++++++++++++++++
 sound/soc/fsl/fsl_esai.c            |  2 +-
 sound/soc/fsl/fsl_spdif.c           |  4 ++--
 sound/soc/kirkwood/kirkwood-i2s.c   |  2 +-
 9 files changed, 32 insertions(+), 9 deletions(-)

-- 
1.9.1
