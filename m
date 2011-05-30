From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 30 May 2011 12:09:40 +0530
Subject: [PATCH 0/3] SPEAr: Add plgpio support
Message-ID: <cover.1306737135.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds spear-plgpio driver and its support on
SPEAr Machines.

It was earlier reviewed as part of following patchset:
"[PATCH V6 00/17] Adding devices support for all spear machines"

Changes since earlier patchset:
 - Moved driver to drivers/gpio/ directory.
 - used new irq routines & definitions in driver.
 - add support for edge irqs.

Viresh Kumar (3):
  gpio/spear-plgpio: Add plgpio driver for SPEAr platform
  SPEAr: Add machine support for plgpio
  SPEAr3xx: Update defconfig for plgpio

 MAINTAINERS                                   |    7 +
 arch/arm/configs/spear3xx_defconfig           |    1 +
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear3xx/include/mach/gpio.h    |  143 +++++++
 arch/arm/mach-spear3xx/spear310.c             |   80 ++++-
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320.c             |   40 ++-
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear6xx/include/mach/gpio.h    |   27 ++
 drivers/gpio/Kconfig                          |    7 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/spear-plgpio.c                   |  490 +++++++++++++++++++++++++
 include/linux/spear-plgpio.h                  |   69 ++++
 13 files changed, 867 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpio/spear-plgpio.c
 create mode 100644 include/linux/spear-plgpio.h

-- 
1.7.2.2
