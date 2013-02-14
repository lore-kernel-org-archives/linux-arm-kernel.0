From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:26:49 +0100
Subject: [PATCH 0/9] linux-next ARM defconfig fixes
Message-ID: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have tried building all ARM default configurations in
linux-next today, and found a number of obvious problems
that came in from somewhere other than the arm-soc tree
(I have a separate series for those).

Here are the fixes I came up with. Please apply or merge
into the original patch that broke them, or find a different
fix that solves the problem.

Arnd Bergmann (9):
  ARM: sa1100/assabet: include platform_device.h directly
  fb/exynos: include platform_device.h
  clk: sunxi: remove stale Makefile entry
  mfd: max8925: fix trivial build warning for non-dt
  ARM: shmobile: mark mackerel sh_mmcif_device __maybe_unused
  drm/pci: move drm_pcie_get_speed_cap_mask inside #ifdef CONFIG_PCI
  ARM defconfigs: add missing inclusions of linux/platform_device.h
  [media] s5p-fimc: fix s5pv210 build
  thermal: rcar: remove __devinitconst

Cc: Dave Airlie <airlied@redhat.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>


 arch/arm/mach-s5pv210/mach-goni.c               |  2 +-
 arch/arm/mach-sa1100/assabet.c                  |  1 +
 arch/arm/mach-shmobile/board-mackerel.c         |  2 +-
 arch/arm/plat-samsung/include/plat/adc.h        |  1 +
 drivers/clk/Makefile                            |  1 -
 drivers/gpu/drm/drm_pci.c                       | 75 ++++++++++++-------------
 drivers/thermal/rcar_thermal.c                  |  2 +-
 drivers/video/backlight/max8925_bl.c            |  6 +-
 drivers/video/clps711xfb.c                      |  1 +
 drivers/video/exynos/exynos_mipi_dsi_common.c   |  1 +
 drivers/video/exynos/exynos_mipi_dsi_lowlevel.c |  1 +
 drivers/video/mmp/fb/mmpfb.c                    |  1 +
 include/linux/platform_data/s3c-hsotg.h         |  2 +
 13 files changed, 49 insertions(+), 47 deletions(-)

-- 
1.8.1.2
