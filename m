From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 10:10:01 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.12
Message-ID: <20170406081001.kjyrisz4f5cdy4a7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is our usual patches for the next merge window.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.12

for you to fetch changes up to cb545960dea2749771c88b0cb26e5adfd12a0315:

  clk: sunxi-ng: Display index when clock registration fails (2017-04-06 09:10:30 +0200)

----------------------------------------------------------------
Allwinner clock patches for 4.12

Support for the new H5 SoC and the PRCM block found in a number of SoCs as
well, plus the usual chunk of fixes and minor enhancements.

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: sunxi: ccu-sun5i needs nkmp

Chen-Yu Tsai (6):
      clk: sunxi-ng: mp: Adjust parent rate for pre-dividers
      clk: sunxi-ng: sun6i: Fix enable bit offset for hdmi-ddc module clock
      clk: sunxi-ng: gate: Support common pre-dividers
      clk: sunxi-ng: mult: Support PLL lock detection
      clk: sunxi-ng: a80: Remodel CPU cluster PLLs as N-type multiplier clocks
      clk: sunxi-ng: a33: Add offset and minimum value for DDR1 PLL N factor

Icenowy Zheng (3):
      clk: sunxi-ng: add Allwinner H5 CCU support for H3 CCU driver
      dt-bindings: update device tree binding for Allwinner PRCM CCUs
      clk: sunxi-ng: add support for PRCM CCUs

Peter Robinson (1):
      clk: sunxi-ng: tighten SoC deps on explicit AllWinner SoCs

Priit Laes (2):
      clk: sunxi-ng: sun5i: Fix mux width for csi clock
      clk: sunxi-ng: Display index when clock registration fails

 .../devicetree/bindings/clock/sunxi-ccu.txt        |  18 +-
 drivers/clk/sunxi-ng/Kconfig                       |  17 +-
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun5i.c                   |   2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  18 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                | 327 ++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 | 213 ++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-r.h                 |  27 ++
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |  70 +++--
 drivers/clk/sunxi-ng/ccu_common.c                  |   4 +-
 drivers/clk/sunxi-ng/ccu_gate.c                    |  47 +++
 drivers/clk/sunxi-ng/ccu_mp.c                      |   8 +
 drivers/clk/sunxi-ng/ccu_mult.c                    |   2 +
 drivers/clk/sunxi-ng/ccu_mult.h                    |   2 +
 include/dt-bindings/clock/sun8i-h3-ccu.h           |   5 +-
 include/dt-bindings/clock/sun8i-r-ccu.h            |  59 ++++
 include/dt-bindings/reset/sun8i-h3-ccu.h           |   5 +-
 include/dt-bindings/reset/sun8i-r-ccu.h            |  53 ++++
 20 files changed, 842 insertions(+), 41 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r.h
 create mode 100644 include/dt-bindings/clock/sun8i-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-r-ccu.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/bfde8115/attachment.sig>
