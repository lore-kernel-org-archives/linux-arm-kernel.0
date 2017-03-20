From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 10:50:04 +0100
Subject: [GIT PULL] Allwinner clock fixes for 4.11
Message-ID: <20170320095004.4vd2edph2u7kxi7l@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following patches for one of the 4.11's rc

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-fixes-for-4.11

for you to fetch changes up to b467e08a15563dede0d37d3233baa24fb97a7310:

  clk: sunxi-ng: fix recalc_rate formula of NKMP clocks (2017-03-20 10:34:05 +0100)

----------------------------------------------------------------
Allwinner clock fixes for 4.11

A few fixes for a bunch of clocks on a few SoCs. The most important one is
probably one that fixes the NKMP clock frequency calculation and could end
up with clocking the CPU frequency to out of bounds rates.

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: sunxi: ccu-sun5i needs nkmp

Chen-Yu Tsai (2):
      clk: sunxi-ng: mp: Adjust parent rate for pre-dividers
      clk: sunxi-ng: sun6i: Fix enable bit offset for hdmi-ddc module clock

Icenowy Zheng (1):
      clk: sunxi-ng: fix recalc_rate formula of NKMP clocks

Philipp Tomsich (1):
      clk: sunxi-ng: Fix div/mult settings for osc12M on A64

 drivers/clk/sunxi-ng/Kconfig          | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c  | 2 +-
 drivers/clk/sunxi-ng/ccu_mp.c         | 8 ++++++++
 drivers/clk/sunxi-ng/ccu_nkmp.c       | 2 +-
 5 files changed, 12 insertions(+), 3 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/fc32e56b/attachment.sig>
