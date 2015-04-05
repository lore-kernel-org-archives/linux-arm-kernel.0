From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 05 Apr 2015 15:43:48 +0300
Subject: [PATCH v2 0/3] Alpine: configuration changes
Message-ID: <55212e04.o5yIiunegJ+wS/Lz%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds configuration changes required for alpine platform.
Please consider it for v4.1.

Using this patchset, the alpine dev. board was able to boot a rootfs from SATA,
using multi_v7_defconfig and "make all" (sorry for the previous alpine_db mistake).

Patch #1 enables support for generic PCI host for ARCH_ALPINE.

Patch #2 adds the device-tree entry for the internal-pci bus.

Patch #3 adds support for alpine and generic-pci to multi_v7_defconfig.

---
V2:
* removed unused interrupts from device-tree entry.
* Added patch #3, previously submitted separately.
* rebased on top of f12318b (for-next)

Tsahee Zidenberg (3):
  ARM: alpine: add support for generic pci
  ARM: dts: alpine: add internal pci
  ARM: multi_v7_defconfig: enable alpine platform

 arch/arm/boot/dts/alpine.dtsi       | 20 ++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig |  2 ++
 arch/arm/mach-alpine/Kconfig        |  2 ++
 3 files changed, 24 insertions(+)

-- 
1.9.1
