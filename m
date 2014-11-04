From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue,  4 Nov 2014 15:52:34 +0800
Subject: [PATCH 0/5] clk: rockchip: add full support for HDMI clock on rk3288
Message-ID: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we are going to make a clock usage solution for rk3288:
1. CPLL and GPLL always not change after assign init;
2. NPLL default as 500MHz, may used for most scene;
3. NPLL may be changed by VOP(HDMI) clock for some special
   frequency requirement.

    I test it with rk3288 evb on top of Heiko's clk-for-next


Kever Yang (5):
  clk: rockchip: add some clock rate into rate table for rk3288
  clk: divider: make clk_divider_recalc/set_rate available
  clk: rockchip: introduce the div_ops handling for composite branches
  clk: rockchip: add the vop_determine_rate for vop dclock
  clk: rockchip: change DCLK_VOP0 to use new COMPOSITE_DIVOPS

 drivers/clk/clk-divider.c         |  4 +--
 drivers/clk/rockchip/clk-rk3288.c | 76 ++++++++++++++++++++++++++++++++++++++-
 drivers/clk/rockchip/clk.c        | 13 ++++---
 drivers/clk/rockchip/clk.h        | 24 +++++++++++++
 include/linux/clk-provider.h      |  4 +++
 5 files changed, 114 insertions(+), 7 deletions(-)

-- 
1.9.1
