From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:19:46 +0000
Subject: [PATCH V6 0/6] clk: imx: add imx8qxp clock support
Message-ID: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds i.MX8QXP clock support which is based
on the clock service provided by SCU firmware.

Note: It depends on SCU driver which has already been merged by Shawn.
So this patch series could go through Shawn's tree as well.

ChangeLog:
v5->v6:
 * simply the driver a lot by re-orgnizing the driver into a few clock types:
   scu clock (merge scu divider/gate/mux) and scu gpr lock which accessing is
   through SCU protocol and LPCG clock which is directly accessible by CPU.
 * LPCG clock is separate from SCU clock, gpr clock is still not used
   and will be added later.
 * remove old year license as the code is totally rewritten
 * scu mux support will be added later as it's also still not used.
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



Dong Aisheng (6):
  clk: imx: add scu clock common part
  dt-bindings: clock: imx8qxp: add SCU clock IDs
  clk: imx: add imx8qxp clk driver
  dt-bindings: clock: add imx8qxp lpcg clock binding
  clk: imx: add lpcg clock support
  clk: imx: add imx8qxp lpcg driver

 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 ++++
 drivers/clk/imx/Kconfig                            |   4 +
 drivers/clk/imx/Makefile                           |   6 +
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 | 198 ++++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.h                 | 102 ++++++++
 drivers/clk/imx/clk-imx8qxp.c                      | 156 +++++++++++
 drivers/clk/imx/clk-lpcg-scu.c                     | 108 ++++++++
 drivers/clk/imx/clk-scu.c                          | 237 +++++++++++++++++
 drivers/clk/imx/clk-scu.h                          |  24 ++
 include/dt-bindings/clock/imx8qxp-clock.h          | 289 +++++++++++++++++++++
 10 files changed, 1175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-lpcg.h
 create mode 100644 drivers/clk/imx/clk-imx8qxp.c
 create mode 100644 drivers/clk/imx/clk-lpcg-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.c
 create mode 100644 drivers/clk/imx/clk-scu.h
 create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h

-- 
2.7.4
