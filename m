From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun, 30 Sep 2018 08:56:15 +0800
Subject: [PATCH V3 00/11] clk: imx: add imx8qxp clock support
Message-ID: <1538268986-24890-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds i.MX8QXP clock support which is based
on the clock service provided by SCU firmware.
It depends on SCU driver.

ChangeLog:
v2->v3:
 * structure and enums name update
 * api usage update due to api change

Dong Aisheng (11):
  clk: imx: add configuration option for mmio clks
  clk: imx: scu: add scu clock common part
  clk: imx: scu: add scu clock divider
  clk: imx: scu: add scu clock gpr divider
  clk: imx: scu: add scu clock gate
  clk: imx: scu: add scu clock gpr gate
  clk: imx: scu: add scu clock mux
  clk: imx: scu: add scu clock gpr mux
  clk: imx: add common imx_clk_hw_fixed functions
  clk: imx: add imx_check_clk_hws helper function
  clk: imx: add imx8qxp clk driver

 arch/arm/mach-imx/Kconfig                 |  11 +
 drivers/clk/Kconfig                       |   1 +
 drivers/clk/imx/Kconfig                   |   7 +
 drivers/clk/imx/Makefile                  |   4 +-
 drivers/clk/imx/clk-common.h              |  27 ++
 drivers/clk/imx/scu/Kconfig               |   5 +
 drivers/clk/imx/scu/Makefile              |  12 +
 drivers/clk/imx/scu/clk-divider-gpr-scu.c | 130 +++++++++
 drivers/clk/imx/scu/clk-divider-scu.c     | 177 +++++++++++++
 drivers/clk/imx/scu/clk-gate-gpr-scu.c    |  88 ++++++
 drivers/clk/imx/scu/clk-gate-scu.c        | 223 ++++++++++++++++
 drivers/clk/imx/scu/clk-imx8qxp.c         | 426 ++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-mux-gpr-scu.c     |  91 +++++++
 drivers/clk/imx/scu/clk-mux-scu.c         | 131 +++++++++
 drivers/clk/imx/scu/clk-scu.c             |  17 ++
 drivers/clk/imx/scu/clk-scu.h             |  97 +++++++
 include/dt-bindings/clock/imx8qxp-clock.h | 362 +++++++++++++++++++++++++
 include/soc/imx/imx8qxp/lpcg.h            | 186 +++++++++++++
 18 files changed, 1994 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/Kconfig
 create mode 100644 drivers/clk/imx/clk-common.h
 create mode 100644 drivers/clk/imx/scu/Kconfig
 create mode 100644 drivers/clk/imx/scu/Makefile
 create mode 100644 drivers/clk/imx/scu/clk-divider-gpr-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-divider-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-gate-gpr-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-gate-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-imx8qxp.c
 create mode 100644 drivers/clk/imx/scu/clk-mux-gpr-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-mux-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-scu.c
 create mode 100644 drivers/clk/imx/scu/clk-scu.h
 create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
 create mode 100644 include/soc/imx/imx8qxp/lpcg.h

-- 
2.7.4
