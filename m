From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 12 Feb 2010 23:13:01 -0500 (EST)
Subject: Git pull request: Orion/Kirkwood stuff for 2.6.34
Message-ID: <alpine.LFD.2.00.1002122305380.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please could you pull:

	git://git.marvell.com/orion for-rmk

The shortlog and diffstat follows:

Alexander Clouter (1):
      [ARM] kirkwood: combine support for openrd base/client support

H Hartley Sweeten (3):
      mach-orion5x/common.c: remove unnecessary (void *) casts
      mach-kirkwood/common.c: remove unnecessary (void *) casts
      mach-dove/common.c: remove unnecessary (void *) casts

Laurie Bradshaw (1):
      [ARM] orion5x: D-link DNS-323 revision A1 power LED

Nicolas Pitre (3):
      [ARM] orion5x: fix some improper includes in Linkstation files
      [ARM] Kirkwood: update defconfig
      [ARM] orion5x: update defconfig

Simon Guinot (4):
      [ARM] Orion5x: set valid GPIO inhibit power-off for d2net
      [ARM] Orion5x: enable SATA LED blinking for d2net
      [ARM] Kirkwood: add LaCie Internet Space v2 support
      [ARM] Kirkwood: define SATA LED for netspace_v2

Zhu Qingsen (1):
      [ARM] Orion: Add Buffalo Linkstation LS-HGL support

 arch/arm/configs/kirkwood_defconfig        |  126 ++++++++---
 arch/arm/configs/orion5x_defconfig         |  101 ++++++--
 arch/arm/mach-dove/common.c                |    8 +-
 arch/arm/mach-kirkwood/Kconfig             |   17 ++
 arch/arm/mach-kirkwood/Makefile            |    3 +-
 arch/arm/mach-kirkwood/common.c            |    8 +-
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   59 +++--
 arch/arm/mach-kirkwood/openrd-setup.c      |  118 +++++++++
 arch/arm/mach-kirkwood/openrd_base-setup.c |   96 --------
 arch/arm/mach-orion5x/Kconfig              |    7 +
 arch/arm/mach-orion5x/Makefile             |    1 +
 arch/arm/mach-orion5x/common.c             |    4 +-
 arch/arm/mach-orion5x/d2net-setup.c        |   45 ++--
 arch/arm/mach-orion5x/dns323-setup.c       |   36 +++-
 arch/arm/mach-orion5x/ls_hgl-setup.c       |  276 ++++++++++++++++++++++
 arch/arm/mach-orion5x/lsmini-setup.c       |    8 +-
 16 files changed, 696 insertions(+), 217 deletions(-)


Nicolas
