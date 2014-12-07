From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  7 Dec 2014 18:21:04 +0100
Subject: [PATCH 0/4] clk: sunxi: mmc: Last bits of phase handling
Message-ID: <1417972868-12055-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are the last patches of the serie converting the custom phase
API to the proper common clock framework API.

These patches have already been discussed in length, only the patch 1
is new and should ease the handling of our MMC clocks.

Thanks,
Maxime

Maxime Ripard (4):
  clk: sunxi: Rework MMC phase clocks
  ARM: sunxi: dt: Add sample and output mmc clocks
  mmc: sunxi: Convert MMC driver to the standard clock phase API
  clk: sunxi: Remove custom phase function

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  72 ++++++++----
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  54 ++++++---
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  44 ++++---
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  72 ++++++++----
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  72 ++++++++----
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  54 ++++++---
 drivers/clk/sunxi/clk-mod0.c                       | 129 +++++++++++----------
 drivers/clk/sunxi/clk-sunxi.c                      |  37 ------
 drivers/mmc/host/sunxi-mmc.c                       |  72 ++++++++----
 include/linux/clk/sunxi.h                          |  22 ----
 11 files changed, 385 insertions(+), 251 deletions(-)
 delete mode 100644 include/linux/clk/sunxi.h

-- 
2.2.0
