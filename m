From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 16 Mar 2018 22:02:06 +0800
Subject: [PATCH v4 0/9] Initial Allwinner H6 support
Message-ID: <20180316140215.28663-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds initial support for the Allwinner H6 SoC.

It's quite different from earlier Allwinner SoCs. For example, the
memory map is refactored, and the CCU is rearranged. It's also the first
Allwinner SoC with PCI Express interface (although the implementation
of the PCI Express controller is broken), and the second one with USB
3.0 (the first one is A80).

This patchset adds the most basical support for it, including the main pin
controller, the main CCU and the basical device tree.

Icenowy Zheng (9):
  pinctrl: sunxi: refactor irq related register function to have desc
  pinctrl: sunxi: introduce IRQ bank conversion function
  pinctrl: sunxi: change irq_bank_base to irq_bank_map
  pinctrl: sunxi: add support for the Allwinner H6 main pin controller
  clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
  dt-bindings: add device tree binding for Allwinner H6 main CCU
  clk: sunxi-ng: add support for the Allwinner H6 CCU
  arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
  arm64: allwinner: h6: add support for Pine H64 board

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    4 +
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
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   22 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |   40 +-
 include/dt-bindings/clock/sun50i-h6-ccu.h          |  124 ++
 include/dt-bindings/reset/sun50i-h6-ccu.h          |   73 ++
 20 files changed, 2359 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
 create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h

-- 
2.15.1
