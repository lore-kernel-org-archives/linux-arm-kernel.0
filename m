From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Dec 2012 17:53:10 +0000
Subject: [PATCH v3 0/6] Add support for a fake, para-virtualised machine
Message-ID: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version three of the patches originally posted here:

  v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/135870.html
  v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137750.html

Thanks to all those who have provided comments so far.
Changes for v3 include:

	* Ripped out *even more* SMP code by rebasing onto latest
	  mainline
	* Removed function-base property from device-tree binding
	* Annotated the low-level firmware invocation functions with
	  noinline to clarify intent
	* Minor cleanups

As usual, testing this relies on KVM support for PSCI, a magic kvmtool
and Mark Rutland's arch-timer patches.

Comments welcome,

Will


Marc Zyngier (1):
  ARM: Dummy Virtual Machine platform support

Will Deacon (5):
  ARM: opcodes: add missing include of linux/linkage.h
  ARM: opcodes: add opcodes definitions for ARM security extensions
  ARM: psci: add devicetree binding for describing PSCI firmware
  ARM: psci: add support for PSCI invocations from the kernel
  ARM: mach-virt: add SMP support using PSCI

 Documentation/devicetree/bindings/arm/psci.txt |  55 +++++++
 arch/arm/Kconfig                               |  12 ++
 arch/arm/Makefile                              |   1 +
 arch/arm/include/asm/opcodes-sec.h             |  24 +++
 arch/arm/include/asm/opcodes.h                 |   1 +
 arch/arm/include/asm/psci.h                    |  36 +++++
 arch/arm/kernel/Makefile                       |   1 +
 arch/arm/kernel/psci.c                         | 211 +++++++++++++++++++++++++
 arch/arm/mach-virt/Kconfig                     |  10 ++
 arch/arm/mach-virt/Makefile                    |   6 +
 arch/arm/mach-virt/platsmp.c                   |  58 +++++++
 arch/arm/mach-virt/virt.c                      |  69 ++++++++
 12 files changed, 484 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/psci.txt
 create mode 100644 arch/arm/include/asm/opcodes-sec.h
 create mode 100644 arch/arm/include/asm/psci.h
 create mode 100644 arch/arm/kernel/psci.c
 create mode 100644 arch/arm/mach-virt/Kconfig
 create mode 100644 arch/arm/mach-virt/Makefile
 create mode 100644 arch/arm/mach-virt/platsmp.c
 create mode 100644 arch/arm/mach-virt/virt.c

-- 
1.8.0
