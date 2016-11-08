From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  8 Nov 2016 18:23:04 +0100
Subject: [PATCH 0/10] ARM: sun5i: Convert sun5i SoCs to sunxi-ng
Message-ID: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is yet another serie bringing more SoCs into the sunxi-ng world.

This is pretty common stuff. Dealing with more corner cases, and adding the
drivers for the SoCs. The A10 and A20 should be pretty close, and pretty
easy to support after that.

Let me know what you think,
Maxime

Maxime Ripard (10):
  clk: sunxi-ng: multiplier: Add fractionnal support
  clk: sunxi-ng: nkm: Deal with fixed post dividers
  clk: sunxi-ng: Implement multiplier offsets
  clk: sunxi-ng: Add clocks and resets indices for sun5i
  clk: sunxi-ng: Implement multiplier maximum
  clk: sunxi-ng: Add A10s CCU driver
  clk: sunxi-ng: Add A13 CCU driver
  clk: sunxi-ng: Add GR8 driver
  ARM: sun5i: Convert to CCU
  ARM: gr8: Convert to CCU

 arch/arm/boot/dts/ntc-gr8.dtsi        | 518 ++-----------------
 arch/arm/boot/dts/sun5i-a10s.dtsi     |  94 +---
 arch/arm/boot/dts/sun5i-a13.dtsi      | 140 +-----
 arch/arm/boot/dts/sun5i-r8.dtsi       |  10 +-
 arch/arm/boot/dts/sun5i.dtsi          | 368 +------------
 drivers/clk/sunxi-ng/Kconfig          |  30 +-
 drivers/clk/sunxi-ng/Makefile         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun5i-a10s.c | 755 +++++++++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun5i-a13.c  | 681 ++++++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun5i-gr8.c  | 684 ++++++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun5i.h      | 129 +++++-
 drivers/clk/sunxi-ng/ccu_div.h        |  10 +-
 drivers/clk/sunxi-ng/ccu_mp.c         |  10 +-
 drivers/clk/sunxi-ng/ccu_mult.c       |  12 +-
 drivers/clk/sunxi-ng/ccu_mult.h       |  24 +-
 drivers/clk/sunxi-ng/ccu_nk.c         |  14 +-
 drivers/clk/sunxi-ng/ccu_nkm.c        |  33 +-
 drivers/clk/sunxi-ng/ccu_nkm.h        |   2 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c       |  17 +-
 drivers/clk/sunxi-ng/ccu_nm.c         |  13 +-
 include/dt-bindings/clock/sun5i-ccu.h | 126 +++++-
 include/dt-bindings/reset/sun5i-ccu.h |  32 +-
 22 files changed, 2690 insertions(+), 1015 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i-a10s.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i-a13.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i-gr8.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i.h
 create mode 100644 include/dt-bindings/clock/sun5i-ccu.h
 create mode 100644 include/dt-bindings/reset/sun5i-ccu.h

base-commit: bc5952be2d424b75ed11ff599b70bc9604e98d42
-- 
git-series 0.8.11
