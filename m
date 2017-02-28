From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Feb 2017 06:14:16 +0100
Subject: [PATCH 0/4] rockchip: fix serial output on rk3036
Message-ID: <20170228051420.7214-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes to the 8250-dw variant revealed issues concerning
how the clock rates are handled on the rk3036 uart.

For one, there was an error in the clock declaration, but also the
shared uart-pll-select-mux also as default got supplied from the apll
that also supplies the cpu and thus gets frequency scaled.

The patches in this series remedy this and make the debug uart
function again on 4.10 + current merge window.


Heiko Stuebner (4):
  clk: rockchip: add "," to mux_pll_src_apll_dpll_gpll_usb480m_p on
    rk3036
  clk: rockchip: add SCLK_UARTPLL to rk3036 clock ids
  clk: rockchip: assign the SCLK_UARTPLL clock id on rk3036
  ARM: dts: rockchip: Make uartpll a child of the gpll on rk3036

 arch/arm/boot/dts/rk3036.dtsi          | 5 +++--
 drivers/clk/rockchip/clk-rk3036.c      | 4 ++--
 include/dt-bindings/clock/rk3036-cru.h | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.11.0
