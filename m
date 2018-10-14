From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 14 Oct 2018 08:07:38 +0000
Subject: [PATCH V4 00/11] clk: imx: add imx8qxp clock support
Message-ID: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds i.MX8QXP clock support which is based
on the clock service provided by SCU firmware.

Note: It depends on SCU driver which has already been merged by Shawn.
So this patch series could go through Shawn's tree as well.

ChangeLog:
v3->v4:
 * scu headfile path update
 * no functionality change
v2->v3:
 * structures/enums name update with imx_sc prefix
 * no functionality change
v1->v2:
 * structure and enums name update
 * api usage update due to api change
 * no functionality change

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
 drivers/clk/imx/scu/clk-divider-gpr-scu.c | 129 +++++++++
 drivers/clk/imx/scu/clk-divider-scu.c     | 176 +++++++++++++
 drivers/clk/imx/scu/clk-gate-gpr-scu.c    |  87 ++++++
 drivers/clk/imx/scu/clk-gate-scu.c        | 222 ++++++++++++++++
 drivers/clk/imx/scu/clk-imx8qxp.c         | 425 ++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-mux-gpr-scu.c     |  90 +++++++
 drivers/clk/imx/scu/clk-mux-scu.c         | 130 +++++++++
 drivers/clk/imx/scu/clk-scu.c             |  17 ++
 drivers/clk/imx/scu/clk-scu.h             |  97 +++++++
 include/dt-bindings/clock/imx8qxp-clock.h | 362 +++++++++++++++++++++++++
 include/soc/imx/imx8qxp/lpcg.h            | 186 +++++++++++++
 18 files changed, 1987 insertions(+), 1 deletion(-)
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
