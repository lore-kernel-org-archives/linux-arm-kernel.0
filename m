From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Aug 2017 10:43:59 +0800
Subject: [GIT PULL] Allwinner clock changes for 4.14
Message-ID: <20170807024359.s6jj5wlgrd3fxe2k@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is the first and possibly only bunch of patches for 4.14.
These are all non critical fixes.

Thanks!
ChenYu


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.14

for you to fetch changes up to 913c3d85b4b562e38242765baa95113c8c7f1c14:

  clk: sunxi-ng: allow set parent clock (PLL_CPUX) for CPUX clock on H3 (2017-08-04 12:05:33 +0800)

----------------------------------------------------------------
Allwinner clock changes for 4.14

Non critical fixes:

  - Fix sunxi-ng/ccu-sunxi-r.h header file guard macro typo

  - Make fractional clock modes really used and correctly configured

  - Make H3 cpu clock rate change correctly to be used with cpufreq

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: h3: gate then ungate PLL CPU clk after rate change

Icenowy Zheng (1):
      clk: sunxi-ng: allow set parent clock (PLL_CPUX) for CPUX clock on H3

Jernej ??krabec (4):
      clk: sunxi-ng: Fix fractional mode for N-M clocks
      clk: sunxi-ng: multiplier: Fix fractional mode
      clk: sunxi-ng: Make fractional helper less chatty
      clk: sunxi-ng: Wait for lock when using fractional mode

Matthias Kaehlcke (1):
      clk: sunxi-ng: Fix header guard of ccu-sun8i-r.h

 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 13 ++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-r.h  |  2 +-
 drivers/clk/sunxi-ng/ccu_frac.c     | 14 ++++++++------
 drivers/clk/sunxi-ng/ccu_frac.h     |  2 +-
 drivers/clk/sunxi-ng/ccu_mult.c     | 10 +++++++---
 drivers/clk/sunxi-ng/ccu_nm.c       | 19 ++++++++++++++++---
 6 files changed, 45 insertions(+), 15 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/8e45ece6/attachment.sig>
