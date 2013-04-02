From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 2 Apr 2013 17:16:03 +0100
Subject: [PATCH 0/3 v5] arm: introduce psci_smp_ops and use them on Xen
Message-ID: <alpine.DEB.2.02.1304021700380.5078@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this is the fifth version of the patch series to move virt_smp_ops out of
mach-virt and make it a generic set of reusable PSCI based smp_ops.
I added a patch to introduce smp_init to this series.
In the last patch I am using smp_init to switch to psci_smp_ops if Xen
is detected on the platform.


Jon Medhurst (1):
      ARM: Enable selection of SMP operations at boot time

Stefano Stabellini (2):
      arm: introduce psci_smp_ops
      xen/arm: introduce xen_early_init, use PSCI on xen

 arch/arm/Kconfig                      |    1 +
 arch/arm/include/asm/mach/arch.h      |    3 +
 arch/arm/include/asm/psci.h           |   29 ++++++++++++++
 arch/arm/include/asm/xen/hypervisor.h |    6 +++
 arch/arm/kernel/Makefile              |    5 ++-
 arch/arm/kernel/psci.c                |    7 +--
 arch/arm/kernel/psci_smp.c            |   67 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c               |   12 +++++-
 arch/arm/mach-virt/Makefile           |    1 -
 arch/arm/mach-virt/platsmp.c          |   58 ----------------------------
 arch/arm/mach-virt/virt.c             |    3 -
 arch/arm/xen/enlighten.c              |   27 ++++++++++---
 12 files changed, 144 insertions(+), 75 deletions(-)


A branch based on "xen/arm: move to mach-virt and support SMP" and
3.9-rc3 is available here:

git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git 3.9-rc3-smp-5


Cheers,

Stefano
