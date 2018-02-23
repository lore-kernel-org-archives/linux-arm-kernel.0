From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 23 Feb 2018 20:25:45 +0800
Subject: [PATCH v3 0/7] Initial Allwinner H6 support
Message-ID: <20180223122552.58049-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds initial support for the Allwinner H6 SoC.

It's quite different from earlier Allwinner SoCs. For example, the
memory map is refactored, and the CCU is rearranged. It's also the first
Allwinner SoC with PCI Express interface, and the second one with USB
3.0 (the first one is A80).

This patchset adds the most basical support for it, including the main pin
controller, the main CCU and the basical device tree.

Icenowy Zheng (7):
  pinctrl: sunxi: refactor irq related register function to have desc
  pinctrl: sunxi: support pin controllers with holes among IRQ banks
  pinctrl: sunxi: add support for the Allwinner H6 main pin controller
  clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
  clk: sunxi-ng: add support for the Allwinner H6 CCU
  arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
  arm64: allwinner: h6: add support for Pine H64 board

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |    1 +
 arch/arm64/boot/dts/allwinner/Makefile             |    1 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |   29 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |  177 +++
 drivers/clk/sunxi-ng/Kconfig                       |    5 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               | 1207 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.h               |   56 +
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |   20 +-
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |    2 +
 drivers/pinctrl/sunxi/Kconfig                      |    4 +
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          |  614 ++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c          |    4 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c          |    4 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   18 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |   44 +-
 include/dt-bindings/clock/sun50i-h6-ccu.h          |  124 ++
 include/dt-bindings/reset/sun50i-h6-ccu.h          |   73 ++
 20 files changed, 2358 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
 create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h

-- 
2.15.1
