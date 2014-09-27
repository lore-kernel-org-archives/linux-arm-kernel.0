From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Sep 2014 10:02:46 +0200
Subject: [GIT PULL] Allwinner clocks additions for 3.18
Message-ID: <20140927080246.GA15025@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Like we discussed on IRC, here is the pull request for the Allwinner SoCs.

Tha most important change for this merge window is the addition of the
phase support for the MMC clocks. Unfortunately, the DT patches
wouldn't apply cleanly on your tree without merging our DT pull
request, so I ended up dropping the 3 last patches that are converting
the MMC driver to this new API, and drops the ugly legacy function.

This will be merged in 3.19 without any trouble.

Thanks!
Maxime

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-3.18

for you to fetch changes up to 9c8176bfb67f98ed9a521b624dcb6ab7fa254aa7:

  clk: sunxi: Add sun8i MBUS clock support (2014-09-27 09:05:43 +0200)

----------------------------------------------------------------
Allwinner Clocks Additions for 3.18

The most important part of this serie is the addition of the phase API to
handle the MMC clocks in the Allwinner SoCs.

Apart from that, the A23 gained a new mbus driver, and there's a fix for a
incorrect divider table on the APB0 clock.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      clk: sunxi: add correct divider table for sun4i-apb0 clock
      clk: sunxi: Add sun8i MBUS clock support

Maxime Ripard (8):
      clk: Include of.h in clock-provider.h
      clk: Add a function to retrieve phase
      clk: sunxi: factors: Invert the probing logic
      clk: sunxi: Introduce mbus compatible
      ARM: sunxi: dt: Switch to the new mbus compatible
      clk: sunxi: Move mod0 clock to a file of its own
      clk: sunxi: Move mbus to mod0 file
      clk: sunxi: mod0: Introduce MMC proper phase handling

Mike Turquette (1):
      clk: introduce clk_set_phase function & callback

 Documentation/devicetree/bindings/clock/sunxi.txt |   4 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                 |   2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                  |   2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                  |   2 +-
 drivers/clk/clk.c                                 |  95 +++++++-
 drivers/clk/sunxi/Makefile                        |   2 +
 drivers/clk/sunxi/clk-factors.c                   | 101 +++++++-
 drivers/clk/sunxi/clk-factors.h                   |  16 +-
 drivers/clk/sunxi/clk-mod0.c                      | 283 ++++++++++++++++++++++
 drivers/clk/sunxi/clk-sun8i-mbus.c                |  78 ++++++
 drivers/clk/sunxi/clk-sunxi.c                     | 161 +-----------
 include/linux/clk-private.h                       |   1 +
 include/linux/clk-provider.h                      |  11 +
 include/linux/clk.h                               |  29 +++
 14 files changed, 624 insertions(+), 163 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-mod0.c
 create mode 100644 drivers/clk/sunxi/clk-sun8i-mbus.c

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140927/58a63d5e/attachment.sig>
