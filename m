From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Dec 2012 17:52:38 +0000
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
Message-ID: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When running Linux on a para-virtualised platform (that is, one where
the guest is aware that it is dealing with virtual devices sitting on
things like virtio or xenbus) we require very little in the way of
platform code and piggy-backing on top of an existing platform can
require a lot of device emulation for very little gain.

These two patches introduce mach-virt: a very simple, DT-based machine
which can be used with kvmtool in conjunction with virtio-based devices.
It's not hard to imagine the same machine being targetted by Xen, which
currently emulates a minimal variant of the vexpress platform.

Note that this patch series depends on the timer rework from Mark
Rutland, posted on Friday:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/135651.html

All feedback welcome. We suspect that most controversy will be around
the name of the thing :)

Will


Marc Zyngier (2):
  ARM: Dummy Virtual Machine platform support
  ARM: SMP support for mach-virt

 arch/arm/Kconfig             |   2 +
 arch/arm/Makefile            |   1 +
 arch/arm/mach-virt/Kconfig   |   9 ++
 arch/arm/mach-virt/Makefile  |   6 ++
 arch/arm/mach-virt/headsmp.S |  38 ++++++++
 arch/arm/mach-virt/platsmp.c | 205 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-virt/virt.c    |  71 +++++++++++++++
 7 files changed, 332 insertions(+)
 create mode 100644 arch/arm/mach-virt/Kconfig
 create mode 100644 arch/arm/mach-virt/Makefile
 create mode 100644 arch/arm/mach-virt/headsmp.S
 create mode 100644 arch/arm/mach-virt/platsmp.c
 create mode 100644 arch/arm/mach-virt/virt.c

-- 
1.8.0
