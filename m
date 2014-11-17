From: kever.yang@rock-chips.com (Kever Yang)
Date: Mon, 17 Nov 2014 22:55:36 +0800
Subject: [RFC PATCH 0/2] clk: rockchip: leave npll for DCLK_VOP0(HDMI) only
Message-ID: <1416236138-11010-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support all kinds of frequency requirement for HDMI on rk3288,
we need a PLL that can change rate at run time.

There are some discussion before at [0], I think we can just leave
the npll for HDMI(DCLK_VOP0) used to make it simple.

Comments are welcome.

[0] https://lkml.org/lkml/2014/11/4/58


Kever Yang (2):
  clk: rockchip: leave npll for VOP0 only
  arm: dts: rockchip: select npll as parent of DCLK_VOP0

 arch/arm/boot/dts/rk3288.dtsi     |  2 ++
 drivers/clk/rockchip/clk-rk3288.c | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
1.9.1
