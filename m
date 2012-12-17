From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 16:35:35 +0000
Subject: [PATCH v2 0/6] Add support for a fake, para-virtualised machine
Message-ID: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is version two of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/135870.html

Given the lively discussion sparked in that thread, there have been a
fair number of changes since the RFC:

	* A client-side implementation of PSCI and proposed DT binding
	* Use of PSCI for SMP boot
	* Removal of the SMP pen code
	* Dropped the RFC tag

Marc hacked up the KVM side separately and this has been tested
successfully with his code using a magic build of kvmtool.

As usual, all feedback welcome.

Cheers,

Will


Marc Zyngier (1):
  ARM: Dummy Virtual Machine platform support

Will Deacon (5):
  ARM: opcodes: add missing include of linux/linkage.h
  ARM: opcodes: add opcodes definitions for ARM security extensions
  ARM: psci: add devicetree binding for describing PSCI firmware
  ARM: psci: add support for PSCI invocations from the kernel
  ARM: mach-virt: add SMP support using PSCI

 Documentation/devicetree/bindings/arm/psci.txt |  58 +++++++
 arch/arm/Kconfig                               |  12 ++
 arch/arm/Makefile                              |   1 +
 arch/arm/include/asm/opcodes-sec.h             |  24 +++
 arch/arm/include/asm/opcodes.h                 |   1 +
 arch/arm/include/asm/psci.h                    |  36 +++++
 arch/arm/kernel/Makefile                       |   1 +
 arch/arm/kernel/psci.c                         | 214 +++++++++++++++++++++++++
 arch/arm/mach-virt/Kconfig                     |  10 ++
 arch/arm/mach-virt/Makefile                    |   6 +
 arch/arm/mach-virt/platsmp.c                   |  76 +++++++++
 arch/arm/mach-virt/virt.c                      |  71 ++++++++
 12 files changed, 510 insertions(+)
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
