From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri,  8 Jan 2016 19:31:36 +0800
Subject: [RESEND RFC PATCH 0/2] Add 100MHz integer multiples of cpu freq table
 for the RK3036
Message-ID: <1452252698-16765-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  We need the cpu changing freqs capability, and considering that emac
ref which is need 50MHz might is under the APLL, meanwhile, we don't
need too many freqs because it may spend more time to find the correct
freq.
  Therefore, we should add 100MHz integer multiples cpu freqs for
emac.


Xing Zheng (2):
  clk: rockchip: rk3036: Add to 100MHz integer multiples of cpu freq
    table
  ARM: dts: rockchip: Update the cpu freqs table

 arch/arm/boot/dts/rk3036.dtsi     |   13 ++++++++++++-
 drivers/clk/rockchip/clk-rk3036.c |   27 ++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
1.7.9.5
