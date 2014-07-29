From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 29 Jul 2014 21:12:04 +0200
Subject: [PATCH 0/4] ARM: rockchip: add dma support
Message-ID: <1406661128-7614-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Rockchip SoCs currently supported use pl330 dma controllers.
The first patch introduces the concept of critical clocks, stolen from
sunxi, as some core clocks shouldn't be disabled under normal circumstances.
The patch is necessary, as the amba bus uses strict clock gating, which
without this patch results in the core aclk getting disabled halting the
system, before other components are able to probe and maybe claim their
clocks.

As the patches have no compile-time dependency on each other, the patchset
could be split with the first patch going through the clock tree and the
other three going through arm-soc.

Heiko Stuebner (4):
  clk: rockchip: protect critical clocks from getting disabled
  ARM: rockchip: enable the AMBA bus
  ARM: dts: rockchip: add rk3288 dma controllers
  ARM: dts: rockchip: add rk3188 dma controllers

 arch/arm/boot/dts/rk3288.dtsi     | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi     | 27 +++++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig    |  1 +
 drivers/clk/rockchip/clk-rk3188.c |  7 +++++++
 drivers/clk/rockchip/clk-rk3288.c |  7 +++++++
 drivers/clk/rockchip/clk.c        | 13 +++++++++++++
 drivers/clk/rockchip/clk.h        |  1 +
 7 files changed, 83 insertions(+)

-- 
2.0.1
