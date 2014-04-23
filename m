From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 23 Apr 2014 14:32:51 +0530
Subject: [PATCH v2 0/4] ARM: DRA7: Add support for DRA72x devices
Message-ID: <1398243775-4145-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA72x devices are single core Cortex A15 devices belonging to the
DRA7 family (Similar to the DRA74x devices which are dual core Cortex
A15 based)

The patches (based off 3.15-rc2) add minimal DT/kernel modifications to add
boot support for DRA72x devices reusing all the kernel data for DRA74x devices.

Rajendra Nayak (4):
  ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
  ARM: dts: Add support for DRA72x family of devices
  ARM: OMAP2+: Add machine entry for dra72x devices
  ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
    varients

 .../devicetree/bindings/arm/omap/omap.txt          |   12 +++--
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
 arch/arm/boot/dts/dra7.dtsi                        |   27 ------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 ++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 +++++++++++
 arch/arm/boot/dts/dra74x.dtsi                      |   41 +++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |   46 ++++++++++++++------
 arch/arm/mach-omap2/soc.h                          |    7 +++
 9 files changed, 144 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x.dtsi

-- 
1.7.9.5
