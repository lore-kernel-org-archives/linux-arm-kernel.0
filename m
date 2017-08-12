From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 12 Aug 2017 20:43:49 +0800
Subject: [PATCH v4 0/3] Allwinner R40 CCU driver
Message-ID: <20170812124352.24148-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 has a CCU like other CCUs after A31, however as it contains
many peripherals (especially SATA), the CCU is complicated.

This patchset adds support for it.

Patch 1 is from Priit's A10/A20 CCU patchset, which is needed for
pll-periph0-sata (like the pll-periph-sata on A10/A20).

Patch 2 adds postdiv support for NKM type clock, which is needed for
pll-sata (with a postdiv of 6).

Patch 3 is the main patch, which adds the support for R40 CCU.

Icenowy Zheng (2):
  clk: sunxi-ng: nkm: add support for fixed post-divider
  clk: sunxi-ng: support R40 SoC

Priit Laes (1):
  clk: sunxi-ng: div: Add support for fixed post-divider

 drivers/clk/sunxi-ng/Kconfig              |    5 +
 drivers/clk/sunxi-ng/Makefile             |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c      | 1240 +++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      |   69 ++
 drivers/clk/sunxi-ng/ccu_div.c            |   22 +-
 drivers/clk/sunxi-ng/ccu_div.h            |    3 +-
 drivers/clk/sunxi-ng/ccu_nkm.c            |   22 +-
 drivers/clk/sunxi-ng/ccu_nkm.h            |    2 +
 include/dt-bindings/clock/sun8i-r40-ccu.h |  187 +++++
 include/dt-bindings/reset/sun8i-r40-ccu.h |  130 +++
 10 files changed, 1674 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.h
 create mode 100644 include/dt-bindings/clock/sun8i-r40-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-r40-ccu.h

-- 
2.13.0
