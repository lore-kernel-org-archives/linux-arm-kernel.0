From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sat, 31 Jan 2015 10:30:12 +0200
Subject: [PATCH v2 0/5] Introducing the Alpine platform.
Message-ID: <54cc9294.fsWS9gCuQbEe29Sh%tsahee@annapurnalabs.com>
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

Patch #4 provides documentation for the available device-tree nodes.

Patch #5 provides a device-tree for Alpine soc and development board.

The patchset was tested with multi_v7_defconfig, adding CONFIG_ARCH_ALPINE

---
V2:
* map physical cpu-id from logical on cpu wakeup
* use syscon/regmap for sysfabric_service implementation
* devicetree format:
**  split between .dtsi and dts
**  dual license
**  node and manufacturer naming
* intoduce devicetree in two separate patches
* multiple format fixes
* rebased on d932006 (for-next)

---
Some CC'd on a prev. message that didn't make it through to the list.. hope this
time it will work. Sorry (removing CCs to avoid spamming you).

Tsahee Zidenberg (5):
  ARM: Alpine: Initial support for Alpine platform
  ARM: Alpine: early-debug print support
  ARM: Alpine: smp support
  ARM: dts: Alpine platform binding documentation
  ARM: dts: Alpine platform devicetree

 .../devicetree/bindings/arm/al,alpine.txt          |  88 +++++++++++++
 .../bindings/arm/cpu-enable-method/al,alpine-smp   |  52 ++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  12 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/alpine-db.dts                    |  35 +++++
 arch/arm/boot/dts/alpine.dtsi                      | 141 +++++++++++++++++++++
 arch/arm/mach-alpine/Kconfig                       |  10 ++
 arch/arm/mach-alpine/Makefile                      |   6 +
 arch/arm/mach-alpine/alpine_cpu_pm.c               |  69 ++++++++++
 arch/arm/mach-alpine/alpine_cpu_pm.h               |  26 ++++
 arch/arm/mach-alpine/alpine_cpu_resume.h           |  38 ++++++
 arch/arm/mach-alpine/alpine_machine.c              |  28 ++++
 arch/arm/mach-alpine/platsmp.c                     |  49 +++++++
 16 files changed, 561 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
 create mode 100644 arch/arm/boot/dts/alpine-db.dts
 create mode 100644 arch/arm/boot/dts/alpine.dtsi
 create mode 100644 arch/arm/mach-alpine/Kconfig
 create mode 100644 arch/arm/mach-alpine/Makefile
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.c
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.h
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_resume.h
 create mode 100644 arch/arm/mach-alpine/alpine_machine.c
 create mode 100644 arch/arm/mach-alpine/platsmp.c

-- 
1.9.1
