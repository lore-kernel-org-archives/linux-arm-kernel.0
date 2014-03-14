From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 14 Mar 2014 14:50:38 +0530
Subject: [PATCH 0/3] ARM: DRA7: Add support for DRA72x devices
Message-ID: <1394788841-15112-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA72x devices are single core Cortex A15 devices belonging to the
DRA7 family (Similar to the DRA75x devices which are dual core Cortex
A15 based)

The patches add minimal DT/kernel modifications to add boot support for
DRA72x devices resuing all the kernel data for DRA75x devices.

Rajendra Nayak (3):
  Documentation: dts: OMAP: Fix typos in DRA752 device name
  arm: dts: Add support for DRA72x family of devices
  ARM: OMAP2+: Add machine entry for dra72x devices

 .../devicetree/bindings/arm/omap/omap.txt          |   10 ++++--
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    4 +--
 arch/arm/boot/dts/dra7.dtsi                        |   22 ------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 +++++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 ++++++++++++++
 arch/arm/boot/dts/dra75x.dtsi                      |   36 ++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |   18 ++++++++++
 8 files changed, 115 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra75x.dtsi

-- 
1.7.9.5
