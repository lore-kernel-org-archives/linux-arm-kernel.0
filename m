From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Sep 2012 21:53:34 -0400
Subject: [GIT PULL V4 4b/5] ARM: Kirkwood: platform_data for v3.7
In-Reply-To: <20120921195714.GY5469@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921195714.GY5469@titan.lakedaemon.net>
Message-ID: <20120922015334.GB5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the platform_data branch for kirkwood.  Nothing I've sent
depends on it.  So, if it's useful, great.  If it causes conflicts with
other conversion work, drop it.

hth,

Jason.

The following changes since commit f161905a29aff0de6f2ed39d5dae6b4fde402730:   

  ARM: Kirkwood: ehci now specified in kirkwood.dtsi.  remove legacy platform init (2012-09-21 18:55:57 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/platform_data

Jason Cooper (2):
      ARM: Kirkwood: board-dockstar: use linux/platform_data/mvsdio.h instead of plat/mvsdio.h
      ARM: Kirkwood: use linux/platform_data/mv643xx.h instead of linux/mv643xx.h

Thomas Petazzoni (8):
      sound: kirkwood: remove useless <plat/audio.h> include
      sound: kirkwood: move <plat/audio.h> to <linux/platform_data/kirkwood-audio.h>  
      usb: ehci-orion: move <plat/ehci-orion.h> to <linux/platform_data/ehci-orion.h> 
      mmc: mvsdio: move <plat/mvsdio.h> to <linux/platform_data/mvsdio.h>
      dma: mv_xor: move <plat/mv_xor.h> to <linux/platform_data/mv_xor.h>
      mtd: orion_nand: move <plat/orion_nand.h> to <linux/platform_data/orion_nand.h> 
      i2c: mv643xx: move <linux/mv643xx_i2c.h> to <linux/platform_data/mv643xx_i2c.h> 
      net: mv643xx_eth: move <linux/mv643xx_eth.h> to <linux/platform_data/mv643xx_eth.h>

 arch/arm/mach-dove/cm-a510.c                       |    2 +-
 arch/arm/mach-dove/common.c                        |    3 +--
 arch/arm/mach-dove/dove-db-setup.c                 |    2 +-
 arch/arm/mach-kirkwood/board-dnskw.c               |    2 +-
 arch/arm/mach-kirkwood/board-dockstar.c            |    4 ++--
 arch/arm/mach-kirkwood/board-dreamplug.c           |    4 ++--
 arch/arm/mach-kirkwood/board-goflexnet.c           |    4 ++--
 arch/arm/mach-kirkwood/board-ib62x0.c              |    2 +-
 arch/arm/mach-kirkwood/board-iconnect.c            |    3 ++-
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |    2 +-
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |    2 +-
 arch/arm/mach-kirkwood/board-lsxl.c                |    2 +-
 arch/arm/mach-kirkwood/board-ts219.c               |    2 +-
 arch/arm/mach-kirkwood/common.c                    |   12 ++++++------
 arch/arm/mach-kirkwood/d2net_v2-setup.c            |    2 +-
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |    4 ++--
 arch/arm/mach-kirkwood/dockstar-setup.c            |    4 ++--
 arch/arm/mach-kirkwood/guruplug-setup.c            |    4 ++--
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c     |    2 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c         |    2 +-
 arch/arm/mach-kirkwood/netxbig_v2-setup.c          |    2 +-
 arch/arm/mach-kirkwood/openrd-setup.c              |    4 ++--
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c       |    2 +-
 arch/arm/mach-kirkwood/rd88f6281-setup.c           |    4 ++--
 arch/arm/mach-kirkwood/sheevaplug-setup.c          |    4 ++--
 arch/arm/mach-kirkwood/t5325-setup.c               |    2 +-
 arch/arm/mach-kirkwood/ts219-setup.c               |    2 +-
 arch/arm/mach-kirkwood/ts41x-setup.c               |    2 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |    2 +-
 arch/arm/mach-mv78xx0/common.c                     |    4 ++--
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |    2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |    2 +-
 arch/arm/mach-orion5x/common.c                     |    6 +++---
 arch/arm/mach-orion5x/d2net-setup.c                |    2 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |    4 ++--
 arch/arm/mach-orion5x/dns323-setup.c               |    2 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |    2 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    4 ++--
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
 arch/arm/plat-orion/common.c                       |    8 ++++----
 arch/arm/plat-orion/include/plat/audio.h           |    7 -------
 arch/arm/plat-orion/include/plat/common.h          |    2 +-
 drivers/dma/mv_xor.c                               |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c                   |    2 +-
 drivers/mmc/host/mvsdio.c                          |    2 +-
 drivers/mtd/nand/orion_nand.c                      |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    2 +-
 drivers/usb/host/ehci-orion.c                      |    2 +-
 include/linux/mv643xx.h                            |    4 ++--
 .../linux/platform_data}/ehci-orion.h              |    6 ++----
 include/linux/platform_data/kirkwood-audio.h       |    7 +++++++
 include/linux/{ => platform_data}/mv643xx_eth.h    |    4 ++--
 include/linux/{ => platform_data}/mv643xx_i2c.h    |    4 ++--
 .../plat => include/linux/platform_data}/mv_xor.h  |    6 ++----
 .../plat => include/linux/platform_data}/mvsdio.h  |    6 ++----
 .../linux/platform_data}/orion_nand.h              |    6 ++----
 sound/soc/kirkwood/kirkwood-i2s.c                  |    2 +-
 sound/soc/kirkwood/kirkwood-openrd.c               |    1 -
 sound/soc/kirkwood/kirkwood-t5325.c                |    1 -
 75 files changed, 108 insertions(+), 118 deletions(-)
 delete mode 100644 arch/arm/plat-orion/include/plat/audio.h
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/ehci-orion.h (78%)
 create mode 100644 include/linux/platform_data/kirkwood-audio.h
 rename include/linux/{ => platform_data}/mv643xx_eth.h (96%)
 rename include/linux/{ => platform_data}/mv643xx_i2c.h (89%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mv_xor.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/mvsdio.h (77%)
 rename {arch/arm/plat-orion/include/plat => include/linux/platform_data}/orion_nand.h (82%)
