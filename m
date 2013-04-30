From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 30 Apr 2013 17:17:32 +0100
Subject: [PATCH v10 0/2] (arm-soc for v3.10) arm: introduce psci_smp_ops
Message-ID: <alpine.DEB.2.02.1304301707290.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this is the tenth version of the patch series to move virt_smp_ops out
of mach-virt and make it a generic set of reusable PSCI based smp_ops.
psci_smp_ops are preferred over the platform smp_ops.  The last patch
introduces smp_init.

Changes in v10:
- add include <linux/types.h> to mach/arch.h.



Jon Medhurst (1):
      ARM: Enable selection of SMP operations at boot time

Stefano Stabellini (1):
      arm: introduce psci_smp_ops

 arch/arm/include/asm/mach/arch.h |    5 ++
 arch/arm/include/asm/psci.h      |    9 ++++
 arch/arm/kernel/Makefile         |    5 ++-
 arch/arm/kernel/psci.c           |    7 +--
 arch/arm/kernel/psci_smp.c       |   90 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c          |    9 +++-
 arch/arm/mach-virt/Makefile      |    1 -
 arch/arm/mach-virt/platsmp.c     |   58 ------------------------
 arch/arm/mach-virt/virt.c        |    3 -
 9 files changed, 119 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm/kernel/psci_smp.c
 delete mode 100644 arch/arm/mach-virt/platsmp.c


git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git 3.9-rc3-psci-ops-10-tag

Cheers,

Stefano
