From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:32 +0200
Subject: [PATCH 00/21] ARM build fixes for 3.10
Message-ID: <1366734653-488286-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a set of bug fixes for build errors and warnings I am
seeing in the various defconfigs and/or allmodconfig builds
on linux-next. The majority of these showed up because we now
include a lot more platforms in allmodconfig than we used to.

Please apply to appropriate maintainer trees or provide
feedback, I can take care of the rest sending those through
arm-soc that I get no feedback on.

	Arnd

Arnd Bergmann (21):
  Turn off -Wmaybe-uninitialized when building with -Os
  ARM: compressed/head.S: work around new binutils warning
  ARM: use optimized do_div only for EABI
  ARM: kvm: define KVM_ARM_MAX_VCPUS unconditionally
  ARM: OMAP2+: add dependencies on ARCH_MULTI_V6/V7
  ARM: tegra: call cpu_do_idle from C code
  ARM: tegra: unify tegra_idle_device definitions
  ASoC: ux500: forward declare msp_i2s_platform_data
  spi/sirf: fix MODULE_DEVICE_TABLE
  ssb: fix alignment of struct bcma_device_id
  drm/tilcdc: use only a single module device table
  mmc: sdhci-tegra: fix MODULE_DEVICE_TABLE
  misc: mark spear13xx-pcie-gadget as broken
  staging: nvec: allow modular build
  staging: comedi/dawboard2000: use mdelay for large delays
  staging/zsmalloc: don't use pgtable-mapping from modules
  tty/serial/sirf: fix MODULE_DEVICE_TABLE
  usb: phy: tegra: don't call into tegra-ehci directly
  usb: phy: don't mark usb_bind_phy as __init
  MFD: ab8500: export ab8500_gpadc_sw_hw_convert properly
  mtd: omap2: allow bulding as a module

 Makefile                                      |  2 +-
 arch/arm/boot/compressed/Makefile             |  2 +-
 arch/arm/boot/compressed/head.S               | 12 ++++++++++++
 arch/arm/include/asm/div64.h                  |  2 +-
 arch/arm/kvm/Kconfig                          |  6 +++---
 arch/arm/mach-omap2/Kconfig                   |  5 +++++
 arch/arm/mach-tegra/cpuidle-tegra114.c        |  5 ++---
 arch/arm/mach-tegra/cpuidle-tegra20.c         |  4 +---
 arch/arm/mach-tegra/cpuidle-tegra30.c         |  4 +---
 arch/arm/mach-tegra/cpuidle.c                 |  2 ++
 arch/arm/mach-tegra/cpuidle.h                 |  4 ++++
 arch/arm/mach-tegra/pm.c                      |  5 +++++
 arch/arm/mach-tegra/sleep-tegra20.S           |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c         |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_slave.c         |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c        |  1 -
 drivers/mfd/ab8500-gpadc.c                    |  2 +-
 drivers/misc/Kconfig                          |  2 +-
 drivers/mmc/host/sdhci-tegra.c                |  2 +-
 drivers/mtd/nand/Kconfig                      |  2 +-
 drivers/spi/spi-sirf.c                        |  2 +-
 drivers/staging/comedi/drivers/daqboard2000.c | 14 +++++++-------
 drivers/staging/nvec/Kconfig                  | 10 +++++-----
 drivers/staging/zsmalloc/zsmalloc-main.c      |  2 +-
 drivers/tty/serial/sirfsoc_uart.c             |  2 +-
 drivers/usb/host/ehci-tegra.c                 | 10 +++++-----
 drivers/usb/otg/otg.c                         |  2 +-
 drivers/usb/phy/tegra_usb_phy.c               | 13 +++++++++----
 include/linux/mod_devicetable.h               |  5 +++--
 include/linux/usb/tegra_usb_phy.h             | 10 +++++-----
 sound/soc/ux500/ux500_msp_i2s.h               |  1 +
 31 files changed, 82 insertions(+), 55 deletions(-)

-- 
1.8.1.2

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Dave Airlie <airlied@linux.ie>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: alsa-devel at alsa-project.org
Cc: dri-devel at lists.freedesktop.org
Cc: linux-mtd at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Cc: spi-devel-general at lists.sourceforge.net
