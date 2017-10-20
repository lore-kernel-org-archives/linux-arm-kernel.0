From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Oct 2017 09:43:24 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.15
Message-ID: <20171020074324.y5ykvzhst3uq6kbz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.15

for you to fetch changes up to 4328a2186e5120cfd34c4f04c6e4b7e74fb8b7b4:

  clk: sunxi-ng: sun4i: Export video PLLs (2017-10-17 19:32:16 +0200)

----------------------------------------------------------------
Allwinner clock changes for 4.15

The most notable changes are:
  - Addition of sigma/delta modulation for the audio PLLs on the newer SoCs
  - A83t Display clocks supports

There's also a bunch of minor fixes that didn't have any impact on current
features provided by the kernel.

----------------------------------------------------------------
Alexander Syring (1):
      clk: sunxi-ng: Fix missing CLK_SET_RATE_PARENT in ccu-sun4i-a10.c

Chen-Yu Tsai (12):
      clk: sunxi-ng: Implement reset control status readback
      clk: sunxi-ng: sun6i: Export video PLLs
      clk: sunxi-ng: sun6i: Rename HDMI DDC clock to avoid name collision
      clk: sunxi-ng: sun5i: Fix bit offset of audio PLL post-divider
      clk: sunxi-ng: nm: Check if requested rate is supported by fractional clock
      clk: sunxi-ng: Add sigma-delta modulation support
      clk: sunxi-ng: nm: Add support for sigma-delta modulation
      clk: sunxi-ng: sun8i: h3: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: sun4i: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: sun5i: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: sun6i: Use sigma-delta modulation for audio PLL
      clk: sunxi-ng: sun8i: a23: Use sigma-delta modulation for audio PLL

Icenowy Zheng (2):
      clk: sunxi-ng: add CLK_SET_RATE_UNGATE to all H3 PLLs
      clk: sunxi-ng: add CLK_SET_RATE_PARENT flag to H3 GPU clock

Jonathan Liu (1):
      clk: sunxi-ng: sun4i: Export video PLLs

Maxime Ripard (1):
      clk: sunxi-ng: Add A83T display clocks

Ondrej Jirman (1):
      clk: sunxi-ng: a83t: Fix invalid csi-mclk mux offset

 drivers/clk/sunxi-ng/Makefile             |   1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c      |  28 ++++--
 drivers/clk/sunxi-ng/ccu-sun4i-a10.h      |   4 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c          |  27 +++--
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c      |  40 +++++---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h      |   8 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c      |  38 ++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c     |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c      |  21 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c       |  56 ++++++-----
 drivers/clk/sunxi-ng/ccu_common.h         |   1 +
 drivers/clk/sunxi-ng/ccu_nm.c             |  25 ++++-
 drivers/clk/sunxi-ng/ccu_nm.h             |  25 +++++
 drivers/clk/sunxi-ng/ccu_reset.c          |  14 +++
 drivers/clk/sunxi-ng/ccu_sdm.c            | 158 ++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.h            |  80 +++++++++++++++
 include/dt-bindings/clock/sun4i-a10-ccu.h |   2 +
 include/dt-bindings/clock/sun6i-a31-ccu.h |   4 +
 18 files changed, 457 insertions(+), 77 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu_sdm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_sdm.h

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/4cc71321/attachment-0001.sig>
