From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:26:15 +0100
Subject: [GIT PULL] Allwinner clock changes for 4.10
Message-ID: <20161115212615.lm3guceyfmdjnhfp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following patches for the next merge window.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-clk-for-4.10

for you to fetch changes up to 0f6f9302b819ca352cfd4f42c18ec08d521f9cae:

  clk: sunxi-ng: sun8i-h3: Set CLK_SET_RATE_PARENT for audio module clocks (2016-11-11 21:47:41 +0100)

----------------------------------------------------------------
Allwinner clock changes for 4.10

The usual patches from us, but most notably the introduction of the A64
clocks unit.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      clk: sunxi-ng: sun8i-a23: Set CLK_SET_RATE_PARENT for audio module clocks
      clk: sunxi-ng: sun8i-h3: Set CLK_SET_RATE_PARENT for audio module clocks

Julia Lawall (1):
      clk: sunxi: mod0: improve function-level documentation

Maxime Ripard (6):
      clk: sunxi-ng: Rename the internal structures
      clk: sunxi-ng: Remove the use of rational computations
      clk: sunxi-ng: Finish to convert to structures for arguments
      clk: sunxi-ng: Add minimums for all the relevant structures and clocks
      clk: sunxi-ng: Implement minimum for multipliers
      clk: sunxi-ng: Add A64 clocks

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |  14 +-
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              | 915 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |  72 ++
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |   6 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |  10 +-
 drivers/clk/sunxi-ng/ccu_div.h                     |   6 +-
 drivers/clk/sunxi-ng/ccu_frac.c                    |  12 +-
 drivers/clk/sunxi-ng/ccu_frac.h                    |  14 +-
 drivers/clk/sunxi-ng/ccu_mp.h                      |   4 +-
 drivers/clk/sunxi-ng/ccu_mult.c                    |  33 +-
 drivers/clk/sunxi-ng/ccu_mult.h                    |  17 +-
 drivers/clk/sunxi-ng/ccu_nk.c                      |  43 +-
 drivers/clk/sunxi-ng/ccu_nk.h                      |   4 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |  45 +-
 drivers/clk/sunxi-ng/ccu_nkm.h                     |   6 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |  55 +-
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |   8 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |  58 +-
 drivers/clk/sunxi-ng/ccu_nm.h                      |   6 +-
 drivers/clk/sunxi/clk-mod0.c                       |   2 +-
 include/dt-bindings/clock/sun50i-a64-ccu.h         | 134 +++
 include/dt-bindings/reset/sun50i-a64-ccu.h         |  98 +++
 24 files changed, 1434 insertions(+), 130 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
 create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/2e76f92b/attachment-0001.sig>
