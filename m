From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Nov 2012 11:13:38 -0800
Subject: [GIT PULL 6/6] omap gpmc changes for v3.8 merge window
In-Reply-To: <pull-1352828737-887235>
References: <pull-1352828737-887235>
Message-ID: <20121113191337.GI6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ba54ab4a49bbad736b0254aa6bdf0cb83013815:

  ARM: OMAP: Remove omap_init_consistent_dma_size() (2012-11-06 16:01:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/gpmc-signed

for you to fetch changes up to 86983087096c072214a229ccad614536d55e483f:

  Merge tag 'gpmc-generic-timing' of git://gitorious.org/x0148406-public/linux-kernel into omap-for-v3.8/gpmc (2012-11-12 15:28:11 -0800)

----------------------------------------------------------------

omap GPMC (General Purpose Memory Controller) updates via Afzal Mohammed <afzal@ti.com>:

These changes provide a generic gpmc timing calculation method,
migrates existing peripherals that makes use of custom gpmc timing
calculation method to use the new generic one.

The generic timing routine has been tested with onenand, smsc911x,
and tusb6010 devices connected to GPMC in addition to simulating
other devices support in the mainline kernel.

----------------------------------------------------------------
Afzal Mohammed (6):
      ARM: OMAP2+: nand: remove redundant rounding
      ARM: OMAP2+: gpmc: handle additional timings
      ARM: OMAP2+: gpmc: generic timing calculation
      ARM: OMAP2+: onenand: generic timing calculation
      ARM: OMAP2+: smc91x: generic timing calculation
      ARM: OMAP2+: tusb6010: generic timing calculation

Tony Lindgren (1):
      Merge tag 'gpmc-generic-timing' of git://gitorious.org/x0148406-public/linux-kernel into omap-for-v3.8/gpmc

 Documentation/bus-devices/ti-gpmc.txt | 122 +++++++++++
 arch/arm/mach-omap2/gpmc-nand.c       |  26 +--
 arch/arm/mach-omap2/gpmc-onenand.c    | 143 ++++---------
 arch/arm/mach-omap2/gpmc-smc91x.c     |  43 ++--
 arch/arm/mach-omap2/gpmc.c            | 373 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.h            | 113 ++++++++--
 arch/arm/mach-omap2/usb-tusb6010.c    | 181 ++++-------------
 7 files changed, 709 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/bus-devices/ti-gpmc.txt
