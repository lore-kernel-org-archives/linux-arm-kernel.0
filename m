From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 28 Nov 2014 01:06:01 +0100
Subject: [GIT PULL] clk: rockchip: second batch for 3.19
Message-ID: <4638213.B2LsUVeJxf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

here is the second (and most likely last) batch of rockchip clock
changes for 3.19. Biggest changes are the pll init stuff and the
mmc clock-phase support for rk3288.

Apart from that only some more clock-ids and minor fixes.

So if this looks ok, please pull


Thanks
Heiko

The following changes since commit 29e94468516cdf191ec839ee39f79e011817276d:

  clk: rockchip: fix clock select order for rk3288 usbphy480m_src (2014-11-16 00:40:19 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-clk2

for you to fetch changes up to 89bf26cbc1a09476c4c4740d16a0ffdfa2192b9c:

  clk: rockchip: Add support for the mmc clock phases using the framework (2014-11-28 00:44:24 +0100)

----------------------------------------------------------------
- clock phase setting capability for the rk3288 mmc clocks
- pll init to allow syncing to actual rate table values
- some more exported clocks
- fixes for some clocks (typos etc) all of them not yet used
  in actual drivers

----------------------------------------------------------------
Alexandru M Stan (2):
      clk: rockchip: add bindings for the mmc clocks
      clk: rockchip: Add support for the mmc clock phases using the framework

Heiko Stuebner (4):
      clk: rockchip: add ability to specify pll-specific flags
      clk: rockchip: setup pll_mux data earlier
      clk: rockchip: add optional sync to pll rate parameters
      clk: rockchip: add ROCKCHIP_PLL_SYNC_RATE flag to some plls

Jeff Chen (2):
      clk: rockchip: add binding ID for DMC (memory controller) clocks on rk3288
      clk: rockchip: use clock ID for DMC (memory controller) on rk3288

Julien CHAUVEAU (3):
      clk: rockchip: fix parent clock for rk3188 hclk_lcdc1
      clk: rockchip: fix clock gate for rk3188 spdif_pre
      clk: rockchip: fix rk3188 USB HSIC PHY clock divider

Sonny Rao (1):
      clk: rockchip: rk3288 export i2s0_clkout for use in DT

 drivers/clk/rockchip/Makefile          |   1 +
 drivers/clk/rockchip/clk-mmc-phase.c   | 154 +++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-pll.c         |  81 +++++++++++++----
 drivers/clk/rockchip/clk-rk3188.c      |  37 ++++----
 drivers/clk/rockchip/clk-rk3288.c      |  32 ++++---
 drivers/clk/rockchip/clk.c             |  11 ++-
 drivers/clk/rockchip/clk.h             |  36 +++++++-
 include/dt-bindings/clock/rk3288-cru.h |  13 +++
 8 files changed, 315 insertions(+), 50 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-mmc-phase.c
