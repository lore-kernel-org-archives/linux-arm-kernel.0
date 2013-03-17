From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Mar 2013 20:15:41 +0000
Subject: [GIT PULL 3/3] ARM: mvebu: soc for v3.10
In-Reply-To: <1363551341.dDc8Eea0.32562@triton>
Message-ID: <1363551341.10D8ED563.32562@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 207b6b8da3195dafe3e0d2143262640ddace74af:

  Merge branch 'mvebu/drivers' into mvebu/soc

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/soc_changes_for_v3.10

for you to fetch changes up to c135394ade12b00be1fdd04f68ff8470207a9b32:

  arm: plat-orion: remove addr-map code

----------------------------------------------------------------
mvebu soc changes for v3.10
    
     - use mvebu-mbus driver for:
        - kirkwood
        - dove
        - orion5x
        - mv78xx
        - mvebu
    
     - depends
        - tags/cleanup_for_v3.10 (mvebu/cleanup)
        - tags/drivers_for_v3.10 (mvebu/drivers)
----------------------------------------------------------------
Thomas Petazzoni (6):
      arm: mach-mvebu: convert to use mvebu-mbus driver
      arm: mach-kirkwood: convert to use mvebu-mbus driver
      arm: mach-dove: convert to use mvebu-mbus driver
      arm: mach-orion5x: convert to use mvebu-mbus driver
      arm: mach-mv78xx0: convert to use the mvebu-mbus driver
      arm: plat-orion: remove addr-map code

 arch/arm/Kconfig                                |   4 +
 arch/arm/boot/dts/armada-370-xp.dtsi            |   5 -
 arch/arm/boot/dts/armada-370.dtsi               |   3 +
 arch/arm/boot/dts/armada-xp.dtsi                |   3 +
 arch/arm/boot/dts/dove.dtsi                     |   3 +-
 arch/arm/boot/dts/kirkwood.dtsi                 |   3 +-
 arch/arm/boot/dts/orion5x-88f5182.dtsi          |  18 ++
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts |   2 +-
 arch/arm/mach-dove/Makefile                     |   2 +-
 arch/arm/mach-dove/addr-map.c                   | 125 -------------
 arch/arm/mach-dove/board-dt.c                   |  13 +-
 arch/arm/mach-dove/common.c                     |  39 ++++-
 arch/arm/mach-dove/common.h                     |   2 +-
 arch/arm/mach-dove/include/mach/dove.h          |   5 +
 arch/arm/mach-kirkwood/Makefile                 |   2 +-
 arch/arm/mach-kirkwood/addr-map.c               |  91 ----------
 arch/arm/mach-kirkwood/board-dt.c               |  19 +-
 arch/arm/mach-kirkwood/common.c                 |  38 +++-
 arch/arm/mach-kirkwood/common.h                 |   2 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h  |   7 +-
 arch/arm/mach-kirkwood/pcie.c                   |   1 -
 arch/arm/mach-mv78xx0/Makefile                  |   2 +-
 arch/arm/mach-mv78xx0/addr-map.c                |  93 ----------
 arch/arm/mach-mv78xx0/common.c                  |  10 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h    |   8 +-
 arch/arm/mach-mv78xx0/pcie.c                    |  21 ++-
 arch/arm/mach-mvebu/Kconfig                     |   1 +
 arch/arm/mach-mvebu/Makefile                    |   2 +-
 arch/arm/mach-mvebu/addr-map.c                  | 137 ---------------
 arch/arm/mach-mvebu/armada-370-xp.c             |   2 +
 arch/arm/mach-mvebu/platsmp.c                   |   2 +
 arch/arm/mach-orion5x/Makefile                  |   2 +-
 arch/arm/mach-orion5x/addr-map.c                | 155 ----------------
 arch/arm/mach-orion5x/board-dt.c                |  24 ++-
 arch/arm/mach-orion5x/common.c                  |  49 +++++-
 arch/arm/mach-orion5x/common.h                  |  13 +-
 arch/arm/mach-orion5x/d2net-setup.c             |   4 +-
 arch/arm/mach-orion5x/db88f5281-setup.c         |  13 +-
 arch/arm/mach-orion5x/dns323-setup.c            |   3 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c         |   4 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h    |   6 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c       |   8 +-
 arch/arm/mach-orion5x/ls-chl-setup.c            |   4 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c            |   4 +-
 arch/arm/mach-orion5x/lsmini-setup.c            |   4 +-
 arch/arm/mach-orion5x/mss2-setup.c              |   3 +-
 arch/arm/mach-orion5x/mv2120-setup.c            |   3 +-
 arch/arm/mach-orion5x/net2big-setup.c           |   4 +-
 arch/arm/mach-orion5x/pci.c                     |   7 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c    |   4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c     |   4 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c         |   7 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c  |   4 +-
 arch/arm/mach-orion5x/ts209-setup.c             |   4 +-
 arch/arm/mach-orion5x/ts409-setup.c             |   4 +-
 arch/arm/mach-orion5x/wnr854t-setup.c           |   4 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c        |   4 +-
 arch/arm/plat-orion/Makefile                    |   6 -
 arch/arm/plat-orion/addr-map.c                  | 175 -------------------
 include/linux/mbus.h                            |   3 +
 60 files changed, 314 insertions(+), 880 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-88f5182.dtsi
 delete mode 100644 arch/arm/mach-dove/addr-map.c
 delete mode 100644 arch/arm/mach-kirkwood/addr-map.c
 delete mode 100644 arch/arm/mach-mv78xx0/addr-map.c
 delete mode 100644 arch/arm/mach-mvebu/addr-map.c
 delete mode 100644 arch/arm/mach-orion5x/addr-map.c
 delete mode 100644 arch/arm/plat-orion/addr-map.c
