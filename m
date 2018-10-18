From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 16:53:42 +0000
Subject: [PATCH V5 0/9] clk: imx: add imx8qxp clock support
Message-ID: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds i.MX8QXP clock support which is based
on the clock service provided by SCU firmware.

Note: It depends on SCU driver which has already been merged by Shawn.
So this patch series could go through Shawn's tree as well.

ChangeLog:
v4->v5:
 Address all Stephen and Sascha's review comments, see details in each patch
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

Dong Aisheng (9):
  clk: imx: add configuration option for mmio clks
  clk: imx: scu: add scu clock common part
  clk: imx: scu: add scu clock divider
  clk: imx: scu: add scu clock gpr divider
  clk: imx: scu: add scu clock gate
  clk: imx: scu: add scu clock gpr gate
  clk: imx: scu: add scu clock mux
  clk: imx: scu: add scu clock gpr mux
  clk: imx: add imx8qxp clk driver

 arch/arm/mach-imx/Kconfig                 |  11 +
 drivers/clk/Kconfig                       |   1 +
 drivers/clk/imx/Kconfig                   |   9 +
 drivers/clk/imx/Makefile                  |  13 +-
 drivers/clk/imx/clk-divider-gpr-scu.c     | 130 +++++++++
 drivers/clk/imx/clk-divider-scu.c         | 171 ++++++++++++
 drivers/clk/imx/clk-gate-gpr-scu.c        |  87 ++++++
 drivers/clk/imx/clk-gate-scu.c            | 228 ++++++++++++++++
 drivers/clk/imx/clk-imx8qxp.c             | 422 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-mux-gpr-scu.c         |  84 ++++++
 drivers/clk/imx/clk-mux-scu.c             | 123 +++++++++
 drivers/clk/imx/clk-scu.c                 |  17 ++
 drivers/clk/imx/clk-scu.h                 |  95 +++++++
 include/dt-bindings/clock/imx8qxp-clock.h | 362 +++++++++++++++++++++++++
 include/soc/imx/imx8qxp/lpcg.h            | 186 +++++++++++++
 15 files changed, 1938 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/Kconfig
 create mode 100644 drivers/clk/imx/clk-divider-gpr-scu.c
 create mode 100644 drivers/clk/imx/clk-divider-scu.c
 create mode 100644 drivers/clk/imx/clk-gate-gpr-scu.c
 create mode 100644 drivers/clk/imx/clk-gate-scu.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp.c
 create mode 100644 drivers/clk/imx/clk-mux-gpr-scu.c
 create mode 100644 drivers/clk/imx/clk-mux-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.h
 create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
 create mode 100644 include/soc/imx/imx8qxp/lpcg.h

-- 
2.7.4
