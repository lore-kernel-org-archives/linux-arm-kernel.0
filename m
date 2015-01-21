From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 20:54:50 +0100
Subject: [PATCH 0/3] ARM: rockchip: provide the watchdog with a clock
Message-ID: <1736604.toH3biuFW2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The snps,dw-wdt needs to read the clock-rate of its supplying clock
for some operations. The clock itself is based on pclk_pd_alive
and is indeed gateable. The caveat is that the gate is living in the
so-called secure-GRF, which isn't even writeable in some boot-modes.

But to have an actual clock reference to the correct clock, implement
a fixed-factor clock, to be substituted when we can control the actual
gate safely.

Heiko Stuebner (3):
  clk: rockchip: add id for watchdog pclk on rk3288
  clk: rockchip: add a dummy clock for the watchdog pclk on rk3288
  ARM: dts: rockchip: add rk3288 watchdog clock

 arch/arm/boot/dts/rk3288.dtsi          | 1 +
 drivers/clk/rockchip/clk-rk3288.c      | 8 ++++++++
 include/dt-bindings/clock/rk3288-cru.h | 1 +
 3 files changed, 10 insertions(+)

-- 
2.1.1
