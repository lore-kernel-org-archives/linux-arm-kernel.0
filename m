From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 25 Jan 2015 20:27:36 +0200
Subject: [PATCH 0/4] Introducing the Alpine platform.
Message-ID: <54c53598.oxirKWtRGTrf8i3s%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Annapurna Labs(TM) is a technology company providing innovative solutions
including chips, software, and systems for the datacenter and enterprise
infrastructure.

Alpine(TM) is one of Annapurna Labs? chip products targeting storage and
networking applications. It is a complete Platform-On-Chip,
integrating 2-4 cortex-A15 cores and multiple innovations to provide
a seamless networking and storage fabric for enterprise and datacenter
equipment.

This patchset provides initial support for the Alpine platform.

Patch #1 contains minimal, single-cpu architecture support.

Patch #2 adds early-debug capabilities via Alpine UART 0.

Patch #3 adds smp-support and a secondary cpu enable-method for the platform.

Patch #4 provides a device-tree for quad-core Alpine, along with documentation
for the available device-tree nodes.

The patchset was built on Linux 3.19-rc3,
tested with multi_v7_defconfig, adding CONFIG_ARCH_ALPINE

Tsahee Zidenberg (4):
  ARM: Alpine: Initial support for Alpine platform
  ARM: Alpine: early-debug print support
  ARM: Alpine: smp support
  ARM: dts: Add initial support for Alpine platform

 .../bindings/arm/annapurna-labs,alpine.txt         |  96 +++++++++++
 .../cpu-enable-method/annapurna-labs,alpine-smp    |  64 ++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  12 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/alpine.dts                       | 181 +++++++++++++++++++++
 arch/arm/mach-alpine/Kconfig                       |   9 +
 arch/arm/mach-alpine/Makefile                      |   6 +
 arch/arm/mach-alpine/alpine_cpu_pm.c               |  68 ++++++++
 arch/arm/mach-alpine/alpine_cpu_pm.h               |  26 +++
 arch/arm/mach-alpine/alpine_cpu_resume.h           |  38 +++++
 arch/arm/mach-alpine/alpine_machine.c              |  28 ++++
 arch/arm/mach-alpine/platsmp.c                     |  48 ++++++
 15 files changed, 581 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/annapurna-labs,alpine-smp
 create mode 100644 arch/arm/boot/dts/alpine.dts
 create mode 100644 arch/arm/mach-alpine/Kconfig
 create mode 100644 arch/arm/mach-alpine/Makefile
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.c
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.h
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_resume.h
 create mode 100644 arch/arm/mach-alpine/alpine_machine.c
 create mode 100644 arch/arm/mach-alpine/platsmp.c

-- 
1.9.1
