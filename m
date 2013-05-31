From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:37 +0200
Subject: [PATCH 00/15] Linux-3.10 ARM randconfig fixes
Message-ID: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi subsystem maintainers,

These are a few patches left over from doing randconfig tests
a couple of weeks ago. Please apply them directly into your
trees unless you see problems. All patches can theoretically
be seen as bug fixes for 3.10, but they are not critical,
so applying them for 3.11 is fine as well.

	Arnd

Arnd Bergmann (15):
  irqdomain: export irq_domain_add_simple
  mtd: omap2: allow bulding as a module
  drm/nouveau: use mdelay instead of large udelay constants
  [SCSI] nsp32: use mdelay instead of large udelay constants
  hwrng: bcm2835: fix MODULE_LICENSE tag
  cpuidle: calxeda: select ARM_CPU_SUSPEND
  cpufreq: spear needs cpufreq table
  thermal: cpu_cooling: fix stub function
  drm: always provide debugfs function prototypes
  drm/tilcd: select BACKLIGHT_LCD_SUPPORT
  iwlegacy: il_pm_ops is only provided for PM_SLEEP
  [media] davinci: vpfe_capture needs i2c
  [media] omap3isp: include linux/mm_types.h
  clk: tegra: provide tegra_periph_reset_assert alternative
  OF: remove #ifdef from linux/of_platform.h

 drivers/char/hw_random/bcm2835-rng.c               |  2 +-
 drivers/cpufreq/Kconfig.arm                        |  1 +
 drivers/cpuidle/Kconfig                            |  1 +
 drivers/gpu/drm/nouveau/core/engine/disp/dacnv50.c |  3 ++-
 drivers/gpu/drm/tilcdc/Kconfig                     |  1 +
 drivers/media/platform/davinci/Kconfig             |  3 +++
 drivers/media/platform/omap3isp/ispqueue.h         |  1 +
 drivers/mtd/nand/Kconfig                           |  2 +-
 drivers/net/wireless/iwlegacy/common.h             |  6 +++---
 drivers/scsi/nsp32.c                               |  2 +-
 include/drm/drmP.h                                 |  3 +--
 include/linux/clk/tegra.h                          |  5 +++++
 include/linux/cpu_cooling.h                        |  4 ++--
 include/linux/of_platform.h                        | 14 +++-----------
 kernel/irq/irqdomain.c                             |  1 +
 15 files changed, 27 insertions(+), 22 deletions(-)

Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: John W. Linville <linville@tuxdriver.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq at vger.kernel.org
Cc: dri-devel at lists.freedesktop.org
Cc: linux-media at vger.kernel.org
Cc: linux-mtd at lists.infradead.org
Cc: linux-pm at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-scsi at vger.kernel.org


-- 
1.8.1.2
