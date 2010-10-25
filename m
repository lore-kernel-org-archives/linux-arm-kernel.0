From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 25 Oct 2010 10:48:25 +0900
Subject: [GIT PULL] genesis updates for 2.6.37-rc1
Message-ID: <20101025014825.GD2173@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Guennadi Liakhovetski (22):
      fbdev: sh_mobile_lcdcfb: use fb_videomode_to_var() instead of open-coding
      fbdev: sh_mobile_hdmi: simplify the EDID reading procedure
      fbdev: sh_mobile_lcdcfb: fix more error paths
      fbdev: sh_mobile_lcdcfb: minor simplifications and clean up
      fbdev: sh_mobile_lcdcfb: Support multiple video modes in platform data
      fbdev: sh_mobile_lcdcfb: fix notifier callback return codes
      fbdev: sh_mobile_lcdcfb: allocate memory, sufficient for the biggest mode
      fbdev: sh_mobile_hdmi: add initial support for modes, other than 720p
      fbdev: sh_mobile_hdmi: enable "external" mode
      fbdev: sh_mobile_hdmi: implement locking
      fbdev: sh_mobile_lcdcfb: separate display variable data from framebuffer data
      fbdev: sh_mobile_hdmi: cosmetic improvements
      fbdev: sh_mobile_hdmi: improve HDMI PHY parameters for high resolutions
      fbdev: sh_mobile_hdmi: support hot-plugging of different HDMI / DVI displays
      ARM: mach-shmobile: add two more video modes for HDMI
      fbdev: sh_mobile_lcdc: reconfigure the framebuffer, when free
      sh: fix an ms7724se compile breakage
      fbdev: sh_mobile_lcdc: make platform videomode table optional
      ARM: mach-shmobile: remove videomodes from ap4evb platform data
      fbdev: sh_mobile_lcdc: relax .check_var() HSYNC test
      fbdev: sh_mobile_hdmi: add support for the "video=" kernel command line option
      ARM: arch-shmobile: Add IMX074 camera sensor data to the AP4EVB platform

Kuninori Morimoto (8):
      ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings
      fbdev: sh-mobile_hdmi: remove un-necessity settings
      ARM: mach-shmobile: pfc-sh7372: modify wrong comment
      ARM: mach-shmobile: sh7372: modify INTCS table
      ARM: mach-shmobile: ap4evb: modify touchpanel judgment condition
      ARM: mach-shmobile: modify wrong array size of div6_reparent_clks
      ARM: mach-shmobile: clock-sh7372: add sh7372_ prefix to global clocks
      ARM: mach-shmobile: clock-sh7372: FSI parent select support

Magnus Damm (6):
      ARM: mach-shmobile: Extend AP4EVB LCD comments
      ARM: mach-shmobile: Use evt2irq() for sh7372 DMAC
      ARM: shmobile: break out sh7372 platform devices
      ARM: shmobile: make AP4EVB MMCIF resource string consistent
      ARM: shmobile: use device name for timer clocks
      ARM: mach-shmobile: add TMU platform data for sh7372

Nicolas Kaiser (1):
      arm/shmobile: remove duplicated include

TAKEI Mitsuharu (1):
      ARM: mach-shmobile: ap4evb: modify LCDC1 irq number

 arch/arm/mach-shmobile/board-ap4evb.c        |  326 +++++++++-----
 arch/arm/mach-shmobile/clock-sh7367.c        |    2 +-
 arch/arm/mach-shmobile/clock-sh7372.c        |   78 +++-
 arch/arm/mach-shmobile/clock-sh7377.c        |    2 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h |   10 +-
 arch/arm/mach-shmobile/intc-sh7372.c         |   28 ++
 arch/arm/mach-shmobile/pfc-sh7372.c          |    8 +-
 arch/arm/mach-shmobile/setup-sh7367.c        |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c        |   94 ++++-
 arch/arm/mach-shmobile/setup-sh7377.c        |    1 -
 arch/sh/boards/mach-ap325rxa/setup.c         |   29 +-
 arch/sh/boards/mach-ecovec24/setup.c         |   60 ++-
 arch/sh/boards/mach-kfr2r09/setup.c          |   29 +-
 arch/sh/boards/mach-migor/setup.c            |   58 ++--
 arch/sh/boards/mach-se/7724/setup.c          |   54 ++-
 drivers/video/sh_mipi_dsi.c                  |   32 +-
 drivers/video/sh_mobile_hdmi.c               |  614 +++++++++++++++++---------
 drivers/video/sh_mobile_lcdcfb.c             |  348 ++++++++++-----
 drivers/video/sh_mobile_lcdcfb.h             |   41 ++
 include/video/sh_mobile_lcdc.h               |    5 +-
 20 files changed, 1213 insertions(+), 607 deletions(-)
 create mode 100644 drivers/video/sh_mobile_lcdcfb.h
