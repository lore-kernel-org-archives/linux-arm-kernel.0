From: long.wanglong@huawei.com (Wang Long)
Date: Fri, 28 Nov 2014 02:15:43 +0000
Subject: [PATCH 0/7] ARM: hisi: enable HiP01 SoC
Message-ID: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patch enable Hisilicon HiP01 SoC. The HiP01 SoC series
chip is designed for networking product, it integrates a rich peripheral
interfaces to support network applications and supports both one 
core or dual cores and quad cores. The core is Cortex A9. 

Wang Long (7):
  ARM: debug: add HiP01 debug uart
  ARM: hisi: enable HiP01 SoC
  ARM: dts: Add hip01-ca9x2 dts file
  ARM: config: enable ARCH_HIP01
  ARM: hisi: add a common smp_prepares_cpus function
  ARM: hisi: rename secondary_startup function
  ARM: hisi: enable smp for HiP01

 .../bindings/arm/hisilicon/hisilicon.txt           |  25 +++++
 arch/arm/Kconfig.debug                             |  10 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/hip01-ca9x2.dts                  |  52 ++++++++++
 arch/arm/boot/dts/hip01.dtsi                       | 110 +++++++++++++++++++++
 arch/arm/configs/hisi_defconfig                    |   1 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/mach-hisi/Kconfig                         |   8 ++
 arch/arm/mach-hisi/core.h                          |   5 +-
 arch/arm/mach-hisi/headsmp.S                       |   2 +-
 arch/arm/mach-hisi/hisilicon.c                     |  10 ++
 arch/arm/mach-hisi/hotplug.c                       |  31 ++++++
 arch/arm/mach-hisi/platsmp.c                       |  56 ++++++++++-
 13 files changed, 307 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/hip01-ca9x2.dts
 create mode 100644 arch/arm/boot/dts/hip01.dtsi

-- 
1.8.3.4
