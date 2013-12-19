From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 19 Dec 2013 17:54:28 +0200
Subject: [PATCH 0/6] efuse driver for Tegra
Message-ID: <1387468474-26521-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver allows userspace to read the raw efuse data. Its userspace
interface is modelled after the sunxi_sid driver which provides similar
functionality for some Allwinner SoCs. It has been tested on
Tegra20 (ventana), Tegra30 (beaverboard) and Tegra114 (dalmore).

TODO:
* test on Tegra124 (venice2)

Peter De Schrijver (6):
  ARM: tegra: export apb dma readl/writel
  misc: fuse: Add efuse driver for Tegra
  ARM: tegra: Add efuse bindings
  ARM: tegra: rework fuse.c
  ARM: Tegra: remove speedo files
  misc: enable fuse drivers

 arch/arm/boot/dts/tegra114.dtsi           |    6 +
 arch/arm/boot/dts/tegra124.dtsi           |    6 +
 arch/arm/boot/dts/tegra20.dtsi            |    7 +
 arch/arm/boot/dts/tegra30.dtsi            |    6 +
 arch/arm/mach-tegra/Makefile              |    3 -
 arch/arm/mach-tegra/apbio.c               |   51 +++--
 arch/arm/mach-tegra/fuse.c                |  121 ++-----------
 arch/arm/mach-tegra/tegra114_speedo.c     |  104 ----------
 arch/arm/mach-tegra/tegra20_speedo.c      |  109 -----------
 arch/arm/mach-tegra/tegra30_speedo.c      |  292 ----------------------------
 drivers/misc/Kconfig                      |    1 +
 drivers/misc/Makefile                     |    1 +
 drivers/misc/fuse/Kconfig                 |   12 ++
 drivers/misc/fuse/Makefile                |    1 +
 drivers/misc/fuse/tegra/Makefile          |    7 +
 drivers/misc/fuse/tegra/fuse-tegra.c      |   96 ++++++++++
 drivers/misc/fuse/tegra/fuse-tegra20.c    |  152 +++++++++++++++
 drivers/misc/fuse/tegra/fuse-tegra30.c    |  192 +++++++++++++++++++
 drivers/misc/fuse/tegra/fuse.h            |   79 ++++++++
 drivers/misc/fuse/tegra/tegra114_speedo.c |  108 +++++++++++
 drivers/misc/fuse/tegra/tegra124_speedo.c |  163 ++++++++++++++++
 drivers/misc/fuse/tegra/tegra20_speedo.c  |  110 +++++++++++
 drivers/misc/fuse/tegra/tegra30_speedo.c  |  293 +++++++++++++++++++++++++++++
 include/linux/tegra-soc.h                 |   17 ++
 24 files changed, 1301 insertions(+), 636 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/tegra114_speedo.c
 delete mode 100644 arch/arm/mach-tegra/tegra20_speedo.c
 delete mode 100644 arch/arm/mach-tegra/tegra30_speedo.c
 create mode 100644 drivers/misc/fuse/Kconfig
 create mode 100644 drivers/misc/fuse/Makefile
 create mode 100644 drivers/misc/fuse/tegra/Makefile
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra.c
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra20.c
 create mode 100644 drivers/misc/fuse/tegra/fuse-tegra30.c
 create mode 100644 drivers/misc/fuse/tegra/fuse.h
 create mode 100644 drivers/misc/fuse/tegra/tegra114_speedo.c
 create mode 100644 drivers/misc/fuse/tegra/tegra124_speedo.c
 create mode 100644 drivers/misc/fuse/tegra/tegra20_speedo.c
 create mode 100644 drivers/misc/fuse/tegra/tegra30_speedo.c

-- 
1.7.7.rc0.72.g4b5ea.dirty
