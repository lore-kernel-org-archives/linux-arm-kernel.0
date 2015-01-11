From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Jan 2015 21:00:53 +0100
Subject: [PATCH v3 0/4] clk: sunxi: mmc: Last bits of phase handling
Message-ID: <1421006457-23631-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are the last patches of the serie converting the custom phase
API to the proper common clock framework API.

These patches have already been discussed in length, only the patch 1
is new and should ease the handling of our MMC clocks.

Thanks,
Maxime

Changes from v2:
  - Rebased on top of v3.19

Changes from v1:
  - Fixed memory leak when a phase clock registration fails
  - Moved the spinlock declaration
  - Updated the DT bindings docs


Maxime Ripard (4):
  clk: sunxi: Rework MMC phase clocks
  ARM: sunxi: dt: Add sample and output mmc clocks
  mmc: sunxi: Convert MMC driver to the standard clock phase API
  clk: sunxi: Remove custom phase function

 Documentation/devicetree/bindings/clock/sunxi.txt  |  13 +-
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  72 +++++++----
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  54 ++++++---
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  44 +++++--
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  72 +++++++----
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  72 +++++++----
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  54 ++++++---
 drivers/clk/sunxi/clk-mod0.c                       | 131 +++++++++++----------
 drivers/clk/sunxi/clk-sunxi.c                      |  37 ------
 drivers/mmc/host/sunxi-mmc.c                       |  73 ++++++++----
 include/linux/clk/sunxi.h                          |  22 ----
 12 files changed, 395 insertions(+), 257 deletions(-)
 delete mode 100644 include/linux/clk/sunxi.h

-- 
2.2.1
