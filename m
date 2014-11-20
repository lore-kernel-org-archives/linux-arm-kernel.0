From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Nov 2014 20:38:49 +0100
Subject: [PATCH v2 0/4] clk: rockchip: allow adjusting pll rates on init
Message-ID: <1416512333-15438-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was found that some firmware versions initialized the pll rates using
suboptimal parameters to achieve frequencies the actual rate table contained
better parameters for.

Therefore this series first adds the possibility to create pll-specific flags
and then adds a flag to adjust the pll rate on init to the parameters from
the rate table.

changes since v1:
- move population of pll_mux before registering the core pll clock
  null pointer exception in the _set_rate callback when called from init

Heiko Stuebner (4):
  clk: rockchip: add ability to specify pll-specific flags
  clk: rockchip: setup pll_mux data earlier
  clk: rockchip: add optional sync to pll rate parameters
  clk: rockchip: add ROCKCHIP_PLL_SYNC_RATE flag to some plls

 drivers/clk/rockchip/clk-pll.c    | 81 +++++++++++++++++++++++++++++++--------
 drivers/clk/rockchip/clk-rk3188.c |  8 ++--
 drivers/clk/rockchip/clk-rk3288.c | 10 ++---
 drivers/clk/rockchip/clk.c        |  3 +-
 drivers/clk/rockchip/clk.h        | 13 ++++++-
 5 files changed, 88 insertions(+), 27 deletions(-)

-- 
2.1.1
