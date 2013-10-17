From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Oct 2013 18:30:34 +0200
Subject: [PATCH 0/8] clk: max77686: Clock provider implementation fixes
Message-ID: <1382027442-1992-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series intends to improve clock provider impementation of max77686
PMIC driver. First two patches are simple fixes of current implementation
to allow correct control of provided clocks. Further patches refactor
the driver to make the code cleaner and prepare for further patches. Then
last two patches add registration of OF clock provider and adjust device
tree nodes of boards containing max77686 chip to contain properties
required by clock provider.

Tested on Exynos4412-based Trats2 board, with additional patches adding
driver being a consumer of one of max77686 clocks.

Tomasz Figa (8):
  clk: max77686: Correct callback used for checking clock status
  clk: max77686: Provide .recalc_rate() operation
  clk: max77686: Refactor successful exit of probe function
  clk: max77686: Make max77686_clk_register() return struct clk *
  clk: max77686: Fix clean-up in error and remove paths
  clk: max77686: Refactor driver data handling
  clk: max77686: Register OF clock provider
  ARM: dts: Add clock provider specific properties to max77686 node

 .../devicetree/bindings/clock/maxim,max77686.txt   | 38 +++++++++
 Documentation/devicetree/bindings/mfd/max77686.txt |  3 +
 arch/arm/boot/dts/cros5250-common.dtsi             |  1 +
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  1 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  1 +
 drivers/clk/clk-max77686.c                         | 97 +++++++++++++---------
 6 files changed, 104 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/maxim,max77686.txt

-- 
1.8.3.2
