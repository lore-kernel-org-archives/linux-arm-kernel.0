From: plaes@plaes.org (Priit Laes)
Date: Sun, 26 Mar 2017 20:20:15 +0300
Subject: [PATCH v2 0/6] ARM: sunxi: Convert sun4i/sun7i series SoCs to sunxi-ng
Message-ID: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie brings A10 (sun4i) and A20 (sun7i) SoCs into the
sunxi-ng world.

As mentioned in sun5i conversion, this is pretty much standard
stuff as all the required clocks were already implemented in
the sunxi-ng framework.

Unfortunately there's an issue with LVDS reset control that
causes issues with LVDS displays unless 'clk_ignore_unused'
option is used.

Need help with that :(

Changes from v1:
 - Drop useless comments
 - Add support for A10 / sun4i.
 - Rename driver to sunxi-a10-a20.
 - Add previously unimplemented clocks.
 - Document the audio pll hardcoded post-divider
 - Add Acked-by: Rob Herring <robh@kernel.org> on patch 4

Priit Laes (6):
  clk: sunxi-ng: Add sun4i/sun7i CCU driver
  ARM: sun7i: Convert to CCU
  ARM: sun4i: Convert to CCU
  dt-bindings: List devicetree binding for the CCU of Allwinner A20
  dt-bindings: List devicetree binding for the CCU of Allwinner A10
  clk: sunxi-ng: Display index when clock registration fails

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      |  636 +----
 arch/arm/boot/dts/sun7i-a20.dtsi                      |  717 +-----
 drivers/clk/sunxi-ng/Kconfig                          |   13 +-
 drivers/clk/sunxi-ng/Makefile                         |    1 +-
 drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.c              | 1532 ++++++++++-
 drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.h              |   59 +-
 drivers/clk/sunxi-ng/ccu_common.c                     |    4 +-
 include/dt-bindings/clock/sunxi-a10-a20-ccu.h         |  208 +-
 include/dt-bindings/reset/sunxi-a10-a20-ccu.h         |   66 +-
 10 files changed, 2050 insertions(+), 1188 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sunxi-a10-a20.h
 create mode 100644 include/dt-bindings/clock/sunxi-a10-a20-ccu.h
 create mode 100644 include/dt-bindings/reset/sunxi-a10-a20-ccu.h

base-commit: 8e19fb843be8934d48b31fafbb32a4176f7feb65
-- 
git-series 0.9.1
