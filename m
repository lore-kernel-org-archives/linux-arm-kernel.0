From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Sep 2016 11:48:35 +0200
Subject: [PATCH v3 0/8] clk: sunxi-ng: Introduce support for A23 and A33 CCUs
Message-ID: <20160908094843.14710-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here is the migration for the A23 and A33 clocks to the sunxi-ng
framework.

It has been tested on SinA33 board, and I made sure that everything
was reported at the exact same rate, that the MMC was still working in
DDR, etc.

This has also been tested to implement the DRM driver, so I'm
confident things will work just fine.

Let me know what you think,
Maxime

Changes from v2:
  - Added the msgbox reset and spinlock clocks
  - Added some doc for the max value for the dividers
  - Removed whitespace error

Changes from v1:
  - Allowed to set a maximum on the dividers, and used that on the CPU
    clocks
  - Renamed the CE (crypto engine) clocks to SS (security system) to
    stick to what's being used in the datasheet
  - Added a TODO to mention that we don't really know whose parents
    are linked to the USB clocks.		  

Maxime Ripard (8):
  clk: sunxi-ng: div: Add mux table macros
  clk: sunxi-ng: div: Add kerneldoc for the _ccu_div structure
  clk: sunxi-ng: div: Allow to set a maximum
  clk: sunxi-ng: mux: Add mux table macro
  clk: sunxi-ng: Add N-class clocks support
  clk: sunxi-ng: Add A33 CCU support
  clk: sunxi-ng: Add A23 CCU
  ARM: sun8i: Convert the A23 and A33 to the CCU

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   2 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 257 ++-----
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  51 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  73 +-
 drivers/clk/sunxi-ng/Kconfig                       |  28 +
 drivers/clk/sunxi-ng/Makefile                      |   3 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h           |  63 ++
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               | 736 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               | 780 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_div.h                     |  66 +-
 drivers/clk/sunxi-ng/ccu_mp.c                      |  23 +-
 drivers/clk/sunxi-ng/ccu_mult.c                    | 133 ++++
 drivers/clk/sunxi-ng/ccu_mult.h                    |  35 +
 drivers/clk/sunxi-ng/ccu_mux.h                     |  26 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |   4 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |  21 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |  16 +-
 include/dt-bindings/clock/sun8i-a23-a33-ccu.h      | 127 ++++
 include/dt-bindings/reset/sun8i-a23-a33-ccu.h      |  87 +++
 19 files changed, 2172 insertions(+), 359 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a23.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a33.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_mult.c
 create mode 100644 include/dt-bindings/clock/sun8i-a23-a33-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-a23-a33-ccu.h

-- 
2.9.3
