From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Nov 2014 11:40:28 +0800
Subject: [PATCH resend 0/4] clk: sunxi: Unify sun4i apb1 clock
Message-ID: <1415245232-20585-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resent with linux-arm-kernel CCed)

Hi everyone,

This series unifies the apb1 clock driver for sun4i, which was
previously split into apb1-mux and apb1. This also fixes the
apb2 clock on sun6i/sun8i, which we now have documents for.

The first 2 patches were done by Emilio.

Patch 1 unifies the apb1-mux and apb1 clock drivers using a
factors clock.

Patch 2 unifies said clocks in the dtsi.

Patch 3 switches the compatibles for apb2 clock on sun6i/sun8i to
the unified sun4i apb1 clock.

Patch 4 gets rid of the incorrect and now unused sun6i apb2 clock
driver.


Cheers
ChenYu


Chen-Yu Tsai (2):
  ARM: dts: sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2 clocks.
  clk: sunxi: Removed unused/incorrect sun6i-a31-apb2-clk driver

Emilio L?pez (2):
  clk: sunxi: unify APB1 clock
  ARM: dts: sunxi: unify APB1 clock

 Documentation/devicetree/bindings/clock/sunxi.txt |  2 --
 arch/arm/boot/dts/sun4i-a10.dtsi                  | 12 ++----------
 arch/arm/boot/dts/sun5i-a10s.dtsi                 | 12 ++----------
 arch/arm/boot/dts/sun5i-a13.dtsi                  | 12 ++----------
 arch/arm/boot/dts/sun6i-a31.dtsi                  | 12 ++----------
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 12 ++----------
 arch/arm/boot/dts/sun8i-a23.dtsi                  | 12 ++----------
 drivers/clk/sunxi/clk-sunxi.c                     | 14 ++------------
 8 files changed, 14 insertions(+), 74 deletions(-)

-- 
2.1.1
