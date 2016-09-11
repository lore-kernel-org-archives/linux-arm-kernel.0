From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Sep 2016 22:21:04 +0200
Subject: [GIT PULL] Allwinner clocks changes for 4.9
Message-ID: <20160911202104.GA2491@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the usual bunch of clock patches for the Allwinner SoCs, this
time converting more SoCs to the new framework.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clk-for-4.9

for you to fetch changes up to d63a5e7c713a68bd368016f2022326a1a91310d8:

  clk: sunxi-ng: Add hardware dependency (2016-09-10 11:41:21 +0200)

----------------------------------------------------------------
Allwinner Clock changes for 4.9

Four more SoCs converted to the new clock framework (A31, A31s, A23 and
A33).

----------------------------------------------------------------
Chen-Yu Tsai (6):
      clk: sunxi-ng: mux: Increase fixed pre-divider div size
      clk: sunxi-ng: nkm: Add mux to support multiple parents
      clk: sunxi-ng: mux: Add support for mux tables
      clk: sunxi-ng: mux: support fixed pre-dividers on multiple parents
      clk: sunxi-ng: mux: Add clk notifier functions
      clk: sunxi-ng: Add A31/A31s clocks

Jean Delvare (1):
      clk: sunxi-ng: Add hardware dependency

Maxime Ripard (8):
      clk: sunxi-ng: mux: Rename mux macro to be consistent
      clk: sunxi-ng: div: Add mux table macros
      clk: sunxi-ng: div: Add kerneldoc for the _ccu_div structure
      clk: sunxi-ng: div: Allow to set a maximum
      clk: sunxi-ng: mux: Add mux table macro
      clk: sunxi-ng: Add N-class clocks support
      clk: sunxi-ng: Add A33 CCU support
      clk: sunxi-ng: Add A23 CCU

 .../devicetree/bindings/clock/sunxi-ccu.txt        |    5 +-
 drivers/clk/sunxi-ng/Kconfig                       |   39 +
 drivers/clk/sunxi-ng/Makefile                      |    4 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               | 1235 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |   72 ++
 drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h           |   63 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c               |  737 ++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  780 +++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   10 +-
 drivers/clk/sunxi-ng/ccu_div.h                     |   66 +-
 drivers/clk/sunxi-ng/ccu_mp.c                      |   23 +-
 drivers/clk/sunxi-ng/ccu_mp.h                      |    2 +-
 drivers/clk/sunxi-ng/ccu_mult.c                    |  133 +++
 drivers/clk/sunxi-ng/ccu_mult.h                    |   35 +
 drivers/clk/sunxi-ng/ccu_mux.c                     |   56 +-
 drivers/clk/sunxi-ng/ccu_mux.h                     |   68 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |   44 +-
 drivers/clk/sunxi-ng/ccu_nkm.h                     |   23 +
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |   21 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |   16 +-
 include/dt-bindings/clock/sun6i-a31-ccu.h          |  187 +++
 include/dt-bindings/clock/sun8i-a23-a33-ccu.h      |  127 ++
 include/dt-bindings/reset/sun6i-a31-ccu.h          |  106 ++
 include/dt-bindings/reset/sun8i-a23-a33-ccu.h      |   87 ++
 24 files changed, 3860 insertions(+), 79 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a23.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a33.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_mult.c
 create mode 100644 include/dt-bindings/clock/sun6i-a31-ccu.h
 create mode 100644 include/dt-bindings/clock/sun8i-a23-a33-ccu.h
 create mode 100644 include/dt-bindings/reset/sun6i-a31-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-a23-a33-ccu.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160911/71472c94/attachment.sig>
