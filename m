From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Aug 2012 20:11:29 -0400
Subject: [GIT PULL] Kirkwood: board changes for v3.7
Message-ID: <20120829001129.GO19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7-v2

Alan M Butler (1):
      ARM: Kirkwood: Iomega ix2-200 DT support

Arnaud Patard (3):
      ARM: Kirkwood: Describe iconnect keys in DT.
      ARM: Kirkwood: Describe iconnect nand in DT.
      ARM: Kirkwood: fix Makefile.boot

Jason Cooper (5):
      ARM: Kirkwood: board-dockstar: use linux/platform_data/mvsdio.h instead of plat/mvsdio.h   
      ARM: Kirkwood: use linux/platform_data/mv643xx.h instead of linux/mv643xx.h
      ARM: Kirkwood: Kconfig: keep DT boards together
      ARM: Kirkwood: update defconfig
      ARM: Kirkwood: add DT boards to defconfig

Sebastian Hesselbarth (2):
      ARM: kirkwood: DT board setup for Seagate FreeAgent Dockstar
      ARM: kirkwood: DT descriptor for Seagate FreeAgent Dockstar

Thomas Petazzoni (15):
      arm: add documentation describing Marvell families of SoC
      mtd: orion_nand: remove <mach/hardware.h> include
      arm: plat-orion: use 'void __iomem *' in addr-map code
      arm: plat-orion: introduce PLAT_ORION_LEGACY hidden config option
      arm: plat-orion: make bridge_virt_base non-const to support DT use case
      arm: mvebu: add basic address decoding support to Armada 370/XP
      arm: mvebu: add address decoding controller to the DT
      sound: kirkwood: remove useless <plat/audio.h> include
      sound: kirkwood: move <plat/audio.h> to <linux/platform_data/kirkwood-audio.h>  
      usb: ehci-orion: move <plat/ehci-orion.h> to <linux/platform_data/ehci-orion.h> 
      mmc: mvsdio: move <plat/mvsdio.h> to <linux/platform_data/mvsdio.h>
      dma: mv_xor: move <plat/mv_xor.h> to <linux/platform_data/mv_xor.h>
      mtd: orion_nand: move <plat/orion_nand.h> to <linux/platform_data/orion_nand.h>
      i2c: mv643xx: move <linux/mv643xx_i2c.h> to <linux/platform_data/mv643xx_i2c.h>
      net: mv643xx_eth: move <linux/mv643xx_eth.h> to <linux/platform_data/mv643xx_eth.h>

 Documentation/arm/Marvell/README                   |  232 ++++++++++++++++++++
 arch/arm/Kconfig                                   |   13 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   57 +++++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   50 ++++-
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  105 +++++++++
 arch/arm/configs/kirkwood_defconfig                |   37 ++--
 arch/arm/mach-dove/addr-map.c                      |    2 +-
 arch/arm/mach-dove/cm-a510.c                       |    2 +-
 arch/arm/mach-dove/common.c                        |    2 +-
 arch/arm/mach-dove/dove-db-setup.c                 |    2 +-
 arch/arm/mach-kirkwood/Kconfig                     |   14 ++
 arch/arm/mach-kirkwood/Makefile                    |    2 +
 arch/arm/mach-kirkwood/Makefile.boot               |    5 +-
 arch/arm/mach-kirkwood/addr-map.c                  |    5 +-
 arch/arm/mach-kirkwood/board-dnskw.c               |    2 +-
 arch/arm/mach-kirkwood/board-dockstar.c            |   61 +++++
 arch/arm/mach-kirkwood/board-dreamplug.c           |    4 +-
 arch/arm/mach-kirkwood/board-dt.c                  |    8 +
 arch/arm/mach-kirkwood/board-goflexnet.c           |    4 +-
 arch/arm/mach-kirkwood/board-ib62x0.c              |    2 +-
 arch/arm/mach-kirkwood/board-iconnect.c            |   49 +----
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |   57 +++++
 arch/arm/mach-kirkwood/board-lsxl.c                |    2 +-
 arch/arm/mach-kirkwood/board-ts219.c               |    2 +-
 arch/arm/mach-kirkwood/common.c                    |   12 +-
 arch/arm/mach-kirkwood/common.h                    |   12 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c            |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |    4 +-
 arch/arm/mach-kirkwood/dockstar-setup.c            |    4 +-
 arch/arm/mach-kirkwood/guruplug-setup.c            |    4 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c     |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c         |    2 +-
 arch/arm/mach-kirkwood/netxbig_v2-setup.c          |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c              |    4 +-
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c       |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c           |    4 +-
 arch/arm/mach-kirkwood/sheevaplug-setup.c          |    4 +-
 arch/arm/mach-kirkwood/t5325-setup.c               |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c               |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c               |    2 +-
 arch/arm/mach-mv78xx0/addr-map.c                   |    4 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |    2 +-
 arch/arm/mach-mv78xx0/common.c                     |    4 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |    2 +-
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/addr-map.c                     |  134 +++++++++++
 arch/arm/mach-orion5x/addr-map.c                   |    5 +-
 arch/arm/mach-orion5x/common.c                     |    6 +-
 arch/arm/mach-orion5x/d2net-setup.c                |    2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |    4 +-
 arch/arm/mach-orion5x/dns323-setup.c               |    2 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |    2 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |    2 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |    2 +-
 arch/arm/mach-orion5x/mss2-setup.c                 |    2 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |    2 +-
 arch/arm/mach-orion5x/net2big-setup.c              |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |    2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |    2 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |    2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |    2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |    2 +-
 arch/arm/mach-orion5x/ts209-setup.c                |    2 +-
 arch/arm/mach-orion5x/ts409-setup.c                |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c               |    2 +-
 arch/arm/mach-orion5x/tsx09-common.c               |    2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |    2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |    2 +-
 arch/arm/plat-orion/Makefile                       |    9 +-
 arch/arm/plat-orion/addr-map.c                     |   11 +-
 arch/arm/plat-orion/common.c                       |    8 +-
 arch/arm/plat-orion/include/plat/addr-map.h        |    4 +-
 arch/arm/plat-orion/include/plat/audio.h           |    7 -
 arch/arm/plat-orion/include/plat/common.h          |    2 +-
 drivers/dma/mv_xor.c                               |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |    2 +-
 drivers/mmc/host/mvsdio.c                          |    2 +-
 drivers/mtd/nand/orion_nand.c                      |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    2 +-
 drivers/usb/host/ehci-orion.c                      |    2 +-
 include/linux/mv643xx.h                            |    4 +-
 .../linux/platform_data}/ehci-orion.h              |    6 +-
 include/linux/platform_data/kirkwood-audio.h       |    7 +
 include/linux/{ => platform_data}/mv643xx_eth.h    |    4 +-
 include/linux/{ => platform_data}/mv643xx_i2c.h    |    4 +-
 .../plat => include/linux/platform_data}/mv_xor.h  |    6 +-
 .../plat => include/linux/platform_data}/mvsdio.h  |    6 +-
 .../linux/platform_data}/orion_nand.h              |    6 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |    2 +-
 sound/soc/kirkwood/kirkwood-openrd.c               |    1 -
 sound/soc/kirkwood/kirkwood-t5325.c                |    1 -
 95 files changed, 890 insertions(+), 207 deletions(-)
 create mode 100644 Documentation/arm/Marvell/README
 create mode 100644 arch/arm/boot/dts/kirkwood-dockstar.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
 create mode 100644 arch/arm/mach-mvebu/addr-map.c
 delete mode 100644 arch/arm/plat-orion/include/plat/audio.h
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/ehci-orion.h (78%)
 create mode 100644 include/linux/platform_data/kirkwood-audio.h
 rename include/linux/{ => platform_data}/mv643xx_eth.h (96%)
 rename include/linux/{ => platform_data}/mv643xx_i2c.h (89%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mv_xor.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mvsdio.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/orion_nand.h (82%)
