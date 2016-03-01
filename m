From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue,  1 Mar 2016 18:07:36 +0800
Subject: [PATCH 0/5] Add more clock compatible features and support the RK3399
 clock
Message-ID: <1456826861-7612-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Series-version: 2

Series-changes: 2
- rename the aplll/apllb to lpll/bpll
- add drv/sample clock nodes for sdmmc/sdio

Hi,
  The patch series add support more mux parameters and multiple
clock providers for the rockchip features of the clock framework,
and support the clock controller for the RK3399.



Xing Zheng (5):
  clk: rockchip: add more mux parameters for new pll sources
  clk: rockchip: Add support for multiple clock providers
  clk: rockchip: add new pll-type for rk3399 and similar socs
  clk: rockchip: add a COMPOSITE_FRACMUX_NOGATE type
  clk: rockchip: add clock controller for the RK3399

 drivers/clk/rockchip/Makefile     |    1 +
 drivers/clk/rockchip/clk-cpu.c    |   14 +-
 drivers/clk/rockchip/clk-pll.c    |  309 +++++++-
 drivers/clk/rockchip/clk-rk3036.c |   20 +-
 drivers/clk/rockchip/clk-rk3188.c |   54 +-
 drivers/clk/rockchip/clk-rk3228.c |   20 +-
 drivers/clk/rockchip/clk-rk3288.c |   22 +-
 drivers/clk/rockchip/clk-rk3368.c |   27 +-
 drivers/clk/rockchip/clk-rk3399.c | 1553 +++++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c        |  148 ++--
 drivers/clk/rockchip/clk.h        |   96 ++-
 11 files changed, 2140 insertions(+), 124 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-rk3399.c

-- 
1.7.9.5
