From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 11:39:18 -0700
Subject: [GIT PULL 5/10] omap board file changes for v3.5 merge window
In-Reply-To: <pull-1336675159-747052>
Message-ID: <mailman.14.1336675216.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a8822e2d570bc265c9fa0347710fbcc7bef8b327:

  Merge branch 'for_3.4/pm/smps-regulator' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into pm-regulator (2012-04-30 10:08:29 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-board-for-v3.5

for you to fetch changes up to 8500746fab2fd69843425fa82192a4e377905336:

  OMAP: omap4panda: Use common configuration for V1V8, V2V1 supplies (2012-05-09 14:22:39 -0700)

----------------------------------------------------------------
Board specific changes for omap.

Note that these are based on omap-pm-regulator-for-v3.5 as
both branches are adding twl regulators.

----------------------------------------------------------------
Ameya Palande (1):
      ARM: OMAP: rx51: Platform support for lis3lv02d accelerometer

Ashwin Bihari (1):
      Add MSUB support for the LogicPD OMAP3530 DevKits

Govindraj.R (1):
      ARM: OMAP: omap2plus_defconfig: Enable ehci-omap and sms95xx support

Igor Grinberg (1):
      ARM: OMAP3: cm-t35: add support for power off

Javier Martinez Canillas (2):
      ARM: OMAP2+: nand: Make board_onenand_init() visible to board code
      ARM: OMAP3: igep0020: Add support for Micron NAND Flash storage memory

Mans Rullgard (1):
      ARM: OMAP2+: craneboard: register emac device

Mircea Gherzan (1):
      ARM: OMAP: WiLink platform data for the PandaBoard

Peter Ujfalusi (3):
      OMAP4: twl-common: Add twl6030 V1V8, V2V1 SMPS common configuration
      OMAP: 4430SDP: Use common configuration for V1V8, V2V1 supplies
      OMAP: omap4panda: Use common configuration for V1V8, V2V1 supplies

Ricardo Neri (3):
      ARM: OMAP: devices: Register platform devices for HDMI audio
      ARM: OMAP4: board-4430sdp: Register platform device for HDMI audio codec
      ARM: OMAP4: board-omap4panda: Register platform device for HDMI audio codec

Russ Dill (1):
      ARM: OMAP: Mark Beagleboard-xM MMC bus as 4-bit

Santosh Shilimkar (1):
      ARM: OMAP2PLUS: Enable HIGHMEM

 arch/arm/configs/omap2plus_defconfig         |    2 +
 arch/arm/mach-omap2/Kconfig                  |    1 +
 arch/arm/mach-omap2/board-4430sdp.c          |   10 ++-
 arch/arm/mach-omap2/board-am3517crane.c      |    2 +
 arch/arm/mach-omap2/board-cm-t35.c           |    5 ++
 arch/arm/mach-omap2/board-flash.c            |    4 +-
 arch/arm/mach-omap2/board-flash.h            |   11 ++++
 arch/arm/mach-omap2/board-igep0020.c         |   74 +++++++++-------------
 arch/arm/mach-omap2/board-omap3beagle.c      |    7 +-
 arch/arm/mach-omap2/board-omap3logic.c       |   26 +++++++-
 arch/arm/mach-omap2/board-omap4panda.c       |   24 ++++++-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   88 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/devices.c                |   31 +++++++++
 arch/arm/mach-omap2/twl-common.c             |   43 +++++++++++++
 arch/arm/mach-omap2/twl-common.h             |    2 +
 include/linux/ti_wilink_st.h                 |    2 +
 16 files changed, 280 insertions(+), 52 deletions(-)
