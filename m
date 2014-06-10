From: robherring2@gmail.com (Rob Herring)
Date: Tue, 10 Jun 2014 09:06:08 -0500
Subject: [PATCH 0/2] Platform specific kconfig clean-ups
Message-ID: <1402409170-1314-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This series is mainly to fix the mess of config options enabling Exynos 
creates. However, there is a general inconsistency in how platform 
specific options are handled, so I've converted all to use menuconfig 
instead of a separate menu or inline options.

Both patches should be applied for 3.16.

Rob

Rob Herring (2):
  ARM: exynos: cleanup kconfig option display
  ARM: use menuconfig for sub-arch menus

 arch/arm/Kconfig               |  3 +--
 arch/arm/mach-bcm/Kconfig      |  7 +++----
 arch/arm/mach-berlin/Kconfig   |  6 +-----
 arch/arm/mach-cns3xxx/Kconfig  |  7 +++----
 arch/arm/mach-exynos/Kconfig   |  6 +-----
 arch/arm/mach-imx/Kconfig      |  7 +++----
 arch/arm/mach-moxart/Kconfig   |  2 +-
 arch/arm/mach-mvebu/Kconfig    |  6 +-----
 arch/arm/mach-nomadik/Kconfig  |  4 +---
 arch/arm/mach-omap2/Kconfig    |  9 ++++++---
 arch/arm/mach-prima2/Kconfig   |  6 ++----
 arch/arm/mach-qcom/Kconfig     |  6 +-----
 arch/arm/mach-shmobile/Kconfig |  4 ++--
 arch/arm/mach-tegra/Kconfig    |  7 +++----
 arch/arm/mach-u300/Kconfig     |  6 +-----
 arch/arm/mach-ux500/Kconfig    |  6 +-----
 arch/arm/mach-vexpress/Kconfig |  7 +++----
 arch/arm/plat-samsung/Kconfig  | 17 +++--------------
 18 files changed, 37 insertions(+), 79 deletions(-)

-- 
1.9.1
