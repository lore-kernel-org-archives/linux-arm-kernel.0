From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Aug 2017 10:45:31 +0800
Subject: [GIT PULL] Allwinner clock changes for 4.14 round 2
Message-ID: <20170821024531.7ghc3n5r57qrrou4@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is the second round of Allwinner clock changes for 4.14.
It includes and supercedes the first pull request I sent two weeks ago.

Please pull.

Thanks!
ChenYu


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.14-2

for you to fetch changes up to cd030a78f7aa06fe216f6665a6ea84b8f3e5b3d3:

  clk: sunxi-ng: support R40 SoC (2017-08-19 17:04:37 +0800)

----------------------------------------------------------------
Allwinner clock changes for 4.14, round 2

Usual improvements:

  - Added support for fixed post-divider on divider and NKM-style clocks

  - Added driver for R40 CCU

Non critical fixes (from round 1):

  - Fix sunxi-ng/ccu-sunxi-r.h header file guard macro typo

  - Make fractional clock modes really used and correctly configured

  - Make H3 cpu clock rate change correctly to be used with cpufreq

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: h3: gate then ungate PLL CPU clk after rate change

Icenowy Zheng (4):
      clk: sunxi-ng: allow set parent clock (PLL_CPUX) for CPUX clock on H3
      clk: sunxi-ng: nkm: add support for fixed post-divider
      dt-bindings: add compatible string for Allwinner R40 CCU
      clk: sunxi-ng: support R40 SoC

Jernej ??krabec (4):
      clk: sunxi-ng: Fix fractional mode for N-M clocks
      clk: sunxi-ng: multiplier: Fix fractional mode
      clk: sunxi-ng: Make fractional helper less chatty
      clk: sunxi-ng: Wait for lock when using fractional mode

Jonathan Liu (1):
      dt-bindings: clock: sunxi-ccu: Add compatibles for sun5i CCU driver

Matthias Kaehlcke (1):
      clk: sunxi-ng: Fix header guard of ccu-sun8i-r.h

Priit Laes (1):
      clk: sunxi-ng: div: Add support for fixed post-divider

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    4 +
 drivers/clk/sunxi-ng/Kconfig                       |    5 +
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   13 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.h                 |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               | 1290 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |   69 ++
 drivers/clk/sunxi-ng/ccu_div.c                     |   22 +-
 drivers/clk/sunxi-ng/ccu_div.h                     |    3 +-
 drivers/clk/sunxi-ng/ccu_frac.c                    |   14 +-
 drivers/clk/sunxi-ng/ccu_frac.h                    |    2 +-
 drivers/clk/sunxi-ng/ccu_mult.c                    |   10 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |   22 +-
 drivers/clk/sunxi-ng/ccu_nkm.h                     |    2 +
 drivers/clk/sunxi-ng/ccu_nm.c                      |   19 +-
 include/dt-bindings/clock/sun8i-r40-ccu.h          |  187 +++
 include/dt-bindings/reset/sun8i-r40-ccu.h          |  130 ++
 17 files changed, 1773 insertions(+), 22 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.h
 create mode 100644 include/dt-bindings/clock/sun8i-r40-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-r40-ccu.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/ae71bf23/attachment.sig>
