From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 17:01:27 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.20
Message-ID: <20180929150127.aky3bijls3ncyunt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here are our usual set of changes for the next merge window.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.20

for you to fetch changes up to 8b2a37870419f4aa6e6f837aa8ec627eae984010:

  dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO0 macro (2018-09-05 09:19:59 +0200)

----------------------------------------------------------------
Allwinner clock changes for 4.20

Our usual set of changes for the Allwinner SoCs clock support.

The most notable changes are:
  - A bunch of changes and fixes to support the A64 display engine
  - Some fixes to support the A83t display engine

----------------------------------------------------------------
Icenowy Zheng (3):
      clk: sunxi-ng: h6: fix bus clocks' divider position
      clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC module clocks
      clk: sunxi-ng: a64: Add max. rate constraint to video PLLs

Jagan Teki (2):
      clk: sunxi-ng: a64: Add minimal rate for video PLLs
      dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO0 macro

Jernej Skrabec (5):
      clk: sunxi-ng: Add maximum rate constraint to NM PLLs
      clk: sunxi-ng: h3/h5: Add max. rate constraint to pll-video
      clk: sunxi-ng: r40: Add max. rate constraint to video PLLs
      clk: sunxi-ng: nkmp: Add constraint for maximum rate
      clk: sunxi-ng: a83t: Add max. rate constraint to video PLLs

Rongyi Chen (1):
      clk: sunxi-ng: h6: fix PWM gate/reset offset

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c      | 48 ++++++++++++++-------------
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h      |  4 ++-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c       | 49 +++++++++++++++-------------
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c      |  2 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c        | 25 +++++++-------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c       | 52 +++++++++++++++---------------
 drivers/clk/sunxi-ng/ccu_nkmp.c            |  7 ++++
 drivers/clk/sunxi-ng/ccu_nkmp.h            |  1 +
 drivers/clk/sunxi-ng/ccu_nm.c              |  7 ++++
 drivers/clk/sunxi-ng/ccu_nm.h              | 30 +++++++++++++++++
 include/dt-bindings/clock/sun50i-a64-ccu.h |  1 +
 11 files changed, 142 insertions(+), 84 deletions(-)

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/e4a271e0/attachment.sig>
