From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 18:50:23 +0800
Subject: [PATCH V3 00/14] add clk_prepare/clk_unprepare to imx drivers
Message-ID: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V2:
 - fix clk_prepare_enable bug

Changes since V1:
 - Add common helper functions clk_prepare_enable/clk_disable_unprepare
 - serial/imx: move clk_disable_unprepare before clk_put

Richard Zhao (14):
      clk: add helper functions clk_prepare_enable and clk_disable_unprepare
      ARM: mxc: time: add clk_prepare/clk_unprepare
      ARM: mxc: ahci: add clk_prepare/clk_unprepare
      ARM: mxc: pwm: add clk_prepare/clk_unprepare
      ARM: mxc: epit: add clk_prepare/clk_unprepare
      ARM: mxc: arch_reset: add clk_prepare/clk_unprepare
      ARM: mxc: audmux-v2: add clk_prepare/clk_unprepare
      ARM: pm-imx5: add clk_prepare/clk_unprepare
      ARM: mx31moboard: add clk_prepare/clk_unprepare
      ARM: mxs: add clk_prepare/clk_unprepare
      serial: imx: add clk_prepare/clk_unprepare
      net: fec: add clk_prepare/clk_unprepare
      i2c: imx: add clk_prepare/clk_unprepare
      mmc: sdhci-esdhc-imx: add clk_prepare/clk_unprepare

 arch/arm/mach-imx/mach-mx31moboard.c          |    2 +-
 arch/arm/mach-mx5/pm-imx5.c                   |    4 ++--
 arch/arm/mach-mxs/system.c                    |    2 +-
 arch/arm/mach-mxs/timer.c                     |    2 +-
 arch/arm/plat-mxc/audmux-v2.c                 |    8 ++++----
 arch/arm/plat-mxc/devices/platform-ahci-imx.c |   16 ++++++++--------
 arch/arm/plat-mxc/epit.c                      |    2 +-
 arch/arm/plat-mxc/pwm.c                       |    4 ++--
 arch/arm/plat-mxc/system.c                    |    2 +-
 arch/arm/plat-mxc/time.c                      |    2 +-
 drivers/i2c/busses/i2c-imx.c                  |    4 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c            |    6 +++---
 drivers/net/ethernet/freescale/fec.c          |   10 +++++-----
 drivers/tty/serial/imx.c                      |    7 +++----
 include/linux/clk.h                           |   20 ++++++++++++++++++++
 15 files changed, 55 insertions(+), 36 deletions(-)

Thanks
Richard
