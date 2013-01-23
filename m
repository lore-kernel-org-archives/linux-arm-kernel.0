From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jan 2013 18:05:07 +0000
Subject: [GIT PULL] psci client-side implementation for 3.9
Message-ID: <20130123180507.GH26811@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again guys,

Please pull my PSCI client-side implementation for 3.9. This is used by
the mach-virt platform, for which I'll send another pull request later
on (since there are some timer dependencies that need resolving first).

As before, I'll keep this branch stable so others can base against it.

Thanks,

Will

--->8

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/virt/psci

for you to fetch changes up to 2bdd424f26be1c98b6e3d9acfffb5559c131c888:

  ARM: psci: add support for PSCI invocations from the kernel (2013-01-10 21:10:20 +0000)

----------------------------------------------------------------
Will Deacon (4):
      ARM: opcodes: add missing include of linux/linkage.h
      ARM: opcodes: add opcodes definitions for ARM security extensions
      ARM: psci: add devicetree binding for describing PSCI firmware
      ARM: psci: add support for PSCI invocations from the kernel

 Documentation/devicetree/bindings/arm/psci.txt |  55 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/Kconfig                               |  10 +++++++++
 arch/arm/include/asm/opcodes-sec.h             |  24 +++++++++++++++++++++
 arch/arm/include/asm/opcodes.h                 |   1 +
 arch/arm/include/asm/psci.h                    |  36 +++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile                       |   1 +
 arch/arm/kernel/psci.c                         | 211 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/psci.txt
 create mode 100644 arch/arm/include/asm/opcodes-sec.h
 create mode 100644 arch/arm/include/asm/psci.h
 create mode 100644 arch/arm/kernel/psci.c
