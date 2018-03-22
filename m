From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Mar 2018 17:04:02 +0100
Subject: [GIT PULL] Allwinner clock changes for 4.17
Message-ID: <20180322160402.o2lon3bbncgss4sv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is our usual pull request for the next merge window.

Thanks!
Maxime

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.17

for you to fetch changes up to f422fa558aada511406432bc5974d3a5bf728227:

  clk: sunxi-ng: add missing hdmi-slow clock for H6 CCU (2018-03-21 12:27:13 +0100)

----------------------------------------------------------------
Allwinner clock changes for 4.17

Our usual bunch of changes for the next merge window. The most significant
addition is the support of the H6 clock unit. Other than that, there's a
bunch of fixes for the video clocks on the H3 and H5, and some Kconfig
cleanup.

----------------------------------------------------------------
Corentin Labbe (1):
      clk: sunxi-ng: remove select on obsolete SUNXI_CCU_X kconfig name

Icenowy Zheng (4):
      clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
      dt-bindings: add device tree binding for Allwinner H6 main CCU
      clk: sunxi-ng: add support for the Allwinner H6 CCU
      clk: sunxi-ng: add missing hdmi-slow clock for H6 CCU

Jernej Skrabec (6):
      clk: sunxi-ng: Mask nkmp factors when setting register
      clk: sunxi-ng: Use u64 for calculation of nkmp rate
      clk: sunxi-ng: Add check for minimal rate to NM PLLs
      clk: sunxi-ng: h3: h5: Add minimal rate for video PLL
      clk: sunxi-ng: h3: h5: Allow some clocks to set parent rate
      clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    4 +
 drivers/clk/sunxi-ng/Kconfig                       |   12 +-
 drivers/clk/sunxi-ng/Makefile                      |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c               | 1211 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.h               |   56 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   32 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |    4 +-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |   56 +-
 drivers/clk/sunxi-ng/ccu_nkmp.h                    |    2 +
 drivers/clk/sunxi-ng/ccu_nm.c                      |    7 +
 drivers/clk/sunxi-ng/ccu_nm.h                      |   27 +
 include/dt-bindings/clock/sun50i-h6-ccu.h          |  125 ++
 include/dt-bindings/clock/sun8i-h3-ccu.h           |    2 +
 include/dt-bindings/reset/sun50i-h6-ccu.h          |   73 ++
 14 files changed, 1578 insertions(+), 34 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
 create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/673d69ef/attachment.sig>
