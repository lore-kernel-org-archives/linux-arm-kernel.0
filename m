From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 15 Nov 2011 06:49:57 +0000 (GMT)
Subject: [PATCH 0/3] Support Samsung S5P OHCI device and driver
Message-ID: <1473398.119441321339796993.JavaMail.weblogic@epml28>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

This patch series adds USB OHCI device and initial driver for Samsung
S5P SoCs and is based from Linux 3.2-rc1. I have tested on SMDKV310 board
using EXYNOS4.

Thanks.

Jingoo Han (4):
       ARM: SAMSUNG: Add USB OHCI device
       ARM: EXYNOS: Add USB OHCI support to SMDKV310 board
       USB: Add S5P OHCI diver

  arch/arm/mach-exynos/Kconfig         |    1 +
  arch/arm/mach-exynos/mach-smdkv310.c |   13 +++++++++++++
  arch/arm/mach-exynos/include/mach/map.h   |    2 +
  arch/arm/plat-s5p/Kconfig                 |    5 ++++
  arch/arm/plat-samsung/devs.c              |   34 +++++++++++++++++++++++++++++
  arch/arm/plat-samsung/include/plat/devs.h |    1 +
  arch/arm/plat-samsung/include/plat/ohci.h |   21 +++++++++++++++++
  drivers/usb/Kconfig         |    1 +
  drivers/usb/host/Kconfig    |    6 +
  drivers/usb/host/ohci-hcd.c |    5 +
  drivers/usb/host/ohci-s5p.c |  273 +++++++++++++++++++++++++++++++++++++++++++
  11 files changed, 362 insertions(+), 0 deletions(-)
  create mode 100644 arch/arm/plat-samsung/include/plat/ohci.h
  create mode 100644 drivers/usb/host/ohci-s5p.c
