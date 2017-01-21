From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Jan 2017 23:50:49 +0100
Subject: [PATCH v4 0/8] ARM: sun5i: Convert sun5i SoCs to sunxi-ng
Message-ID: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is yet another serie bringing more SoCs into the sunxi-ng world.

This is pretty common stuff. Dealing with more corner cases, and adding the
drivers for the SoCs. The A10 and A20 should be pretty close, and pretty
easy to support after that.

Let me know what you think,
Maxime

Changes from v3:
  - Added Chen-Yu acked-by
  - Split the minimum fix to a separate patch

Changes from v2:
  - Removed the osc3M, and added a fixed prediv that applies to all
    parents.
  - Made a cosmetic change asked by Chen-Yu
  - Fixed the maximum multiplier when having a different offset
  - Added CLK_SET_RATE_PARENT for the SPDIF
  - Made a comment on what are the differences between the SoCs

Changes from v1:
  - Rebased on top of 4.10
  - Dropped post divider patch
  - Merged all the CCU drivers in a single one
  - Added the code to deal with multiplier maximum
  - Added a comment for the PLL audio offset
  - Added CLK_IS_CRITICAL to the DDR PLL
  - Added the fixed pre-divider to the AHB clock
  - Added a bunch of CLK_SET_RATE_PARENT

Maxime Ripard (8):
  clk: sunxi-ng: multiplier: Add fractional support
  clk: sunxi-ng: Implement factors offsets
  clk: sunxi-ng: mult: Fix minimum in round rate
  clk: sunxi-ng: Implement multiplier maximum
  clk: sunxi-ng: Implement global pre-divider
  clk: sunxi-ng: Add sun5i CCU driver
  ARM: sun5i: Convert to CCU
  ARM: gr8: Convert to CCU

 arch/arm/boot/dts/sun5i-a10s.dtsi     |   85 +--
 arch/arm/boot/dts/sun5i-a13.dtsi      |  140 +----
 arch/arm/boot/dts/sun5i-gr8.dtsi      |  520 +------------
 arch/arm/boot/dts/sun5i-r8.dtsi       |   10 +-
 arch/arm/boot/dts/sun5i.dtsi          |  353 +---------
 drivers/clk/sunxi-ng/Kconfig          |   10 +-
 drivers/clk/sunxi-ng/Makefile         |    1 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c      | 1022 ++++++++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun5i.h      |   67 ++-
 drivers/clk/sunxi-ng/ccu_common.h     |    2 +-
 drivers/clk/sunxi-ng/ccu_div.h        |   10 +-
 drivers/clk/sunxi-ng/ccu_mp.c         |   10 +-
 drivers/clk/sunxi-ng/ccu_mult.c       |   30 +-
 drivers/clk/sunxi-ng/ccu_mult.h       |   24 +-
 drivers/clk/sunxi-ng/ccu_mux.c        |    8 +-
 drivers/clk/sunxi-ng/ccu_nk.c         |   22 +-
 drivers/clk/sunxi-ng/ccu_nkm.c        |   26 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c       |   25 +-
 drivers/clk/sunxi-ng/ccu_nm.c         |   17 +-
 include/dt-bindings/clock/sun5i-ccu.h |  103 +++-
 include/dt-bindings/reset/sun5i-ccu.h |   32 +-
 21 files changed, 1493 insertions(+), 1024 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun5i.h
 create mode 100644 include/dt-bindings/clock/sun5i-ccu.h
 create mode 100644 include/dt-bindings/reset/sun5i-ccu.h

base-commit: f9ca9b952ee139fbb9cd4d354a33f440bc1049cd
-- 
git-series 0.8.11
