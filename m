From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sun, 28 Apr 2013 15:50:20 +0100
Subject: [PATCH 0/2 v9] arm: introduce psci_smp_ops
Message-ID: <alpine.DEB.2.02.1304281544240.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this is the nineth version of the patch series to move virt_smp_ops out
of mach-virt and make it a generic set of reusable PSCI based smp_ops.
psci_smp_ops are preferred over the platform smp_ops.  The last patch
introduces smp_init.

Only one change in this last iteration: the PSCI related comment has
been moved from psci.h to psci_smp.c.


Jon Medhurst (1):
      ARM: Enable selection of SMP operations at boot time

Stefano Stabellini (1):
      arm: introduce psci_smp_ops

 arch/arm/include/asm/mach/arch.h |    3 +
 arch/arm/include/asm/psci.h      |    9 ++++
 arch/arm/kernel/Makefile         |    5 ++-
 arch/arm/kernel/psci.c           |    7 +--
 arch/arm/kernel/psci_smp.c       |   90 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c          |    9 +++-
 arch/arm/mach-virt/Makefile      |    1 -
 arch/arm/mach-virt/platsmp.c     |   58 ------------------------
 arch/arm/mach-virt/virt.c        |    3 -
 9 files changed, 117 insertions(+), 68 deletions(-)

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git 3.9-rc3-psci-ops-9-tag

Cheers,

Stefano
