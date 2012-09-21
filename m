From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Sep 2012 15:57:14 -0400
Subject: [GIT PULL V3 4/5] ARM: Kirkwood: cleanup for v3.7
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120921195714.GY5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


NOTE:  This branch depends on both kirkwood/boards and kirkwood/dt (and,
by extension, kirkwood/addr_decode).  Some of that got pulled into this
summary (kirkwood/boards).  Is this correct?  Sould I be basing the
pullreq on v3.6-rc5?  That would summarize all three branches.  Doesn't
seem as useful.

If it isn't clear, please ask.

thx,

Jason.

The following changes since commit 81d143f47f12368ab4be0cde10aaf379994f3594:

  ARM: kirkwood: Use devicetree to define DNS-32[05] fan (2012-09-21 18:27:09 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/cleanup

Alan M Butler (1):
      ARM: Kirkwood: Iomega ix2-200 DT support

Jamie Lentin (1):
      ARM: kirkwood: Trim excess #includes in board-dnskw.c

Jason Cooper (4):
      Merge branch 'kirkwood/boards' into kirkwood/cleanup
      ARM: Kirkwood: ehci now specified in kirkwood.dtsi.  remove legacy platform init
      ARM: Kirkwood: board-dockstar: use linux/platform_data/mvsdio.h instead of plat/mvsdio.h
      ARM: Kirkwood: use linux/platform_data/mv643xx.h instead of linux/mv643xx.h

Russell King (1):
      ARM: Dove: allow PCI to be disabled

Sebastian Hesselbarth (8):
      ARM: kirkwood: DT board setup for Seagate FreeAgent Dockstar
      ARM: kirkwood: DT descriptor for Seagate FreeAgent Dockstar
      ARM: dove: unify clock setup
      ARM: dove: add clock gating control
      ARM: dove: add crypto engine
      ARM: dove: add device tree based machine descriptor
      ARM: dove: add device tree descriptors
      ARM: dove: SolidRun CuBox DT

Thomas Petazzoni (9):
      arm: add documentation describing Marvell families of SoC
      sound: kirkwood: remove useless <plat/audio.h> include
      sound: kirkwood: move <plat/audio.h> to <linux/platform_data/kirkwood-audio.h>  
      usb: ehci-orion: move <plat/ehci-orion.h> to <linux/platform_data/ehci-orion.h> 
      mmc: mvsdio: move <plat/mvsdio.h> to <linux/platform_data/mvsdio.h>
      dma: mv_xor: move <plat/mv_xor.h> to <linux/platform_data/mv_xor.h>
      mtd: orion_nand: move <plat/orion_nand.h> to <linux/platform_data/orion_nand.h> 
      i2c: mv643xx: move <linux/mv643xx_i2c.h> to <linux/platform_data/mv643xx_i2c.h> 
      net: mv643xx_eth: move <linux/mv643xx_eth.h> to <linux/platform_data/mv643xx_eth.h>

Valentin Longchamp (1):
      ARM: initial DTS support for km_kirkwood

 Documentation/arm/Marvell/README                   |  232 ++++++++++++++++++++
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/boot/dts/dove-cm-a510.dts                 |   38 ++++
 arch/arm/boot/dts/dove-cubox.dts                   |   42 ++++
 arch/arm/boot/dts/dove-dove-db.dts                 |   38 ++++
 arch/arm/boot/dts/dove.dtsi                        |  143 ++++++++++++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   57 +++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  105 +++++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   29 +++
 arch/arm/mach-dove/Kconfig                         |    7 +
 arch/arm/mach-dove/Makefile                        |    4 +-
 arch/arm/mach-dove/Makefile.boot                   |    4 +
 arch/arm/mach-dove/cm-a510.c                       |    2 +-
 arch/arm/mach-dove/common.c                        |  155 ++++++++++++-
 arch/arm/mach-dove/common.h                        |    4 +
 arch/arm/mach-dove/dove-db-setup.c                 |    2 +-
 arch/arm/mach-dove/include/mach/pm.h               |   54 +++--
 arch/arm/mach-kirkwood/Kconfig                     |   21 ++
 arch/arm/mach-kirkwood/Makefile                    |    3 +
 arch/arm/mach-kirkwood/Makefile.boot               |    3 +
 arch/arm/mach-kirkwood/board-dnskw.c               |   11 +-
 arch/arm/mach-kirkwood/board-dockstar.c            |   60 +++++
 arch/arm/mach-kirkwood/board-dreamplug.c           |    4 +-
 arch/arm/mach-kirkwood/board-dt.c                  |   12 +
 arch/arm/mach-kirkwood/board-goflexnet.c           |    4 +-
 arch/arm/mach-kirkwood/board-ib62x0.c              |    2 +-
 arch/arm/mach-kirkwood/board-iconnect.c            |    3 +-
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |   55 +++++
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |   56 +++++
 arch/arm/mach-kirkwood/board-lsxl.c                |    2 +-
 arch/arm/mach-kirkwood/board-ts219.c               |    2 +-
 arch/arm/mach-kirkwood/common.c                    |   12 +-
 arch/arm/mach-kirkwood/common.h                    |   18 ++
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
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |    2 +-
 arch/arm/mach-mv78xx0/common.c                     |    4 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |    2 +-
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
 arch/arm/plat-orion/common.c                       |    8 +-
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
 94 files changed, 1212 insertions(+), 155 deletions(-)
 create mode 100644 Documentation/arm/Marvell/README
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cubox.dts
 create mode 100644 arch/arm/boot/dts/dove-dove-db.dts
 create mode 100644 arch/arm/boot/dts/dove.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-dockstar.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-km_kirkwood.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
 create mode 100644 arch/arm/mach-kirkwood/board-km_kirkwood.c
 delete mode 100644 arch/arm/plat-orion/include/plat/audio.h
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/ehci-orion.h (78%)
 create mode 100644 include/linux/platform_data/kirkwood-audio.h
 rename include/linux/{ => platform_data}/mv643xx_eth.h (96%)
 rename include/linux/{ => platform_data}/mv643xx_i2c.h (89%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mv_xor.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mvsdio.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/orion_nand.h (82%)
