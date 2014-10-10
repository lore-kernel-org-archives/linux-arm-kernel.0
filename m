From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu,  9 Oct 2014 21:50:28 -0700
Subject: [PATCH v2 0/2] init some clock rate from dts for rk3288
Message-ID: <1412916630-8256-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add init rate for PLLs and some bus clock  from dts for rk3288,
add two clock rate of 400M and 500M into rate table for we will use it.
We need Doug's patch to make "aclk_cpu" get set properly:
	<https://patchwork.kernel.org/patch/5038781/>

Changes in v2:
- change the PLL setting of 400M to meet the constraints of TRM
- add review and test tag
- add some explanation in commit message

Kever Yang (2):
  clk: rockchip: add 400MHz and 500MHz for rk3288 clock rate
  ARM: dts: enable init rate for clock

 arch/arm/boot/dts/rk3288.dtsi     | 10 ++++++++++
 drivers/clk/rockchip/clk-rk3288.c |  2 ++
 2 files changed, 12 insertions(+)

-- 
1.9.1
