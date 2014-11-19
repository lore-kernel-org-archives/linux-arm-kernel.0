From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 19 Nov 2014 15:11:55 +0100
Subject: [PATCH 0/3] clk: rockchip: allow adjusting pll rates on init
Message-ID: <1694711.2HxVABHk0T@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was found that some firmware versions initialized the pll rates using
suboptimal parameters to achieve frequencies the actual rate table contained
better parameters for.

Therefore this series first adds the possibility to create pll-specific flags
and then adds a flag to adjust the pll rate on init to the parameters from
the rate table.

This series was tested on rk3066, rk3188 and rk3288 based boards.

Heiko Stuebner (3):
  clk: rockchip: add ability to specify pll-specific flags
  clk: rockchip: add optional sync to pll rate parameters
  clk: rockchip: add ROCKCHIP_PLL_SYNC_RATE flag to some plls

 drivers/clk/rockchip/clk-pll.c    | 54 ++++++++++++++++++++++++++++++++++++++-
 drivers/clk/rockchip/clk-rk3188.c |  8 +++---
 drivers/clk/rockchip/clk-rk3288.c | 10 ++++----
 drivers/clk/rockchip/clk.c        |  3 ++-
 drivers/clk/rockchip/clk.h        | 13 ++++++++--
 5 files changed, 75 insertions(+), 13 deletions(-)

-- 
2.1.1
