From: khilman@ti.com (Kevin Hilman)
Date: Fri, 07 Jan 2011 15:29:03 -0800
Subject: [GIT PULL] misc. fixes for 2.6.38-rc
Message-ID: <87hbdkjnsw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here's a queue of misc. fixes for 2.6.38.  This branch is on top of your
current omap-fixes branch.

Kevin

The following changes since commit a9b365bdc328bd66e97087d0dba0b9a3d9eb1ac6:

  omap2+: wdt: trivial sparse fixes (2011-01-06 19:58:28 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git fixes-for-tony

Felipe Balbi (1):
      arm: omap: gpio: don't access irq_desc array directly

Koen Kooi (3):
      omap3: beaglexm: fix EHCI power up GPIO dir
      omap3: beaglexm: fix DVI reset GPIO
      omap3: beaglexm: fix power on of DVI

Mika Westerberg (1):
      OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+

Nishanth Menon (4):
      OMAP3+: sr_device: include pm header
      OMAP2+: TWL: make conversion routines static
      OMAP2+: TWL: include pm header for init protos
      omap2+: pm_bus: make functions used as pointers as static

Santosh Shilimkar (5):
      omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
      omap2plus: voltage: Trivial warning fix 'no return statement'
      omap2plus: voltage: Trivial linking fix 'undefined reference'
      omap2plus: voltage: Trivial linking fix for 'EINVAL' undeclared
      omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'

 arch/arm/mach-omap2/board-omap3beagle.c   |   37 +++++++++++++++--
 arch/arm/mach-omap2/clockdomain.h         |    2 -
 arch/arm/mach-omap2/omap_twl.c            |   10 +++--
 arch/arm/mach-omap2/pm_bus.c              |    4 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |   63 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/sr_device.c           |    1 +
 arch/arm/plat-omap/gpio.c                 |   12 ++++--
 arch/arm/plat-omap/include/plat/voltage.h |   17 ++++++--
 8 files changed, 124 insertions(+), 22 deletions(-)
