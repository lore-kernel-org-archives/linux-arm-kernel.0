From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 18 Apr 2013 16:04:44 +0100
Subject: [PATCH 0/3 v7] arm: introduce psci_smp_ops
Message-ID: <alpine.DEB.2.02.1304181556210.7254@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this is the seventh version of the patch series to move virt_smp_ops out
of mach-virt and make it a generic set of reusable PSCI based smp_ops.
psci_smp_ops are preferred over the platform smp_ops.
The last patch introduces smp_init.

I removed the patch that makes use of smp_init in Xen, because it
depends on other Xen changes. I'll send it separately.
This version of the series is independent of other changes.


Jon Medhurst (1):
      ARM: Enable selection of SMP operations at boot time

Stefano Stabellini (2):
      arm: introduce psci_smp_ops
      arm: prefer psci_smp_ops over mdesc->smp

 arch/arm/include/asm/mach/arch.h |    3 ++
 arch/arm/include/asm/psci.h      |   29 ++++++++++++++++
 arch/arm/kernel/Makefile         |    5 ++-
 arch/arm/kernel/psci.c           |    7 ++--
 arch/arm/kernel/psci_smp.c       |   67 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c          |    9 ++++-
 arch/arm/mach-virt/Makefile      |    1 -
 arch/arm/mach-virt/platsmp.c     |   58 --------------------------------
 arch/arm/mach-virt/virt.c        |    3 --
 9 files changed, 114 insertions(+), 68 deletions(-)


git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git 3.9-rc3-psci-ops-7-tag

Cheers,

Stefano
