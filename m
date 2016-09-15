From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu, 15 Sep 2016 16:05:00 -0500
Subject: [RFC PATCH v2 0/5] Add support for hi3520 
Message-ID: <20160915210505.21878-1-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory series for adding the ARMv5/v6 hi3520 SoCs.
Assumptions were made when adding hi3620 that don't hold water in
light of adding support for the hi3520 SoC.  Fix the issue by renaming
config options and other namespaces to avoid collisions with the new
work.

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
Changes for v2:
 - Included cover letter
 - Unsplit some patches
 - Added new dts/dts files to show why

Marty Plummer (5):
  ARM: hisi: Make 3620 explicit, remove wildcards
  clk: hi3620: Make 3620 explicit, remove wildcard
  dmaengine: hi3620: Make hi3620 explicit
  ARM: hisi: enable devicetree support for hi3520
  ARM: hisi: add devicetree for hi3520

 arch/arm/Kconfig.debug                  |   2 +-
 arch/arm/boot/dts/Makefile              |   4 +-
 arch/arm/boot/dts/hi3520-1176-dm77a.dts |  62 +++++++++++
 arch/arm/boot/dts/hi3520-1176.dtsi      | 178 ++++++++++++++++++++++++++++++++
 arch/arm/configs/hisi_defconfig         |   2 +-
 arch/arm/configs/multi_v7_defconfig     |   2 +-
 arch/arm/mach-hisi/Kconfig              |  32 ++++--
 arch/arm/mach-hisi/core.h               |  10 +-
 arch/arm/mach-hisi/hisilicon.c          |  34 +++++-
 arch/arm/mach-hisi/hotplug.c            |  16 +--
 arch/arm/mach-hisi/platsmp.c            |  24 ++---
 drivers/clk/hisilicon/Makefile          |   2 +-
 drivers/dma/Kconfig                     |   2 +-
 13 files changed, 325 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/boot/dts/hi3520-1176-dm77a.dts
 create mode 100644 arch/arm/boot/dts/hi3520-1176.dtsi

-- 
2.9.3
