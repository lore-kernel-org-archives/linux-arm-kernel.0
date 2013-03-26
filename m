From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 26 Mar 2013 14:40:56 +0000
Subject: [PATCH v2 0/6] xen/arm: move to mach-virt and support SMP
Message-ID: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series, based on 3.9-rc3, moves xenvm to mach-virt and
implements SMP support in Xen on ARM.


Changes from v1:
- move the percpu variable argument fix in xen_init_events to a separate
  patch;
- remove unused variable in xen_init_events;
- add an RFC patch to initialize PSCI from smp_set_ops and use it if
  available.


Stefano Stabellini (6):
      xen/arm: actually pass a non-NULL percpu pointer to request_percpu_irq
      xen/arm: SMP support
      xen: move the xenvm machine to mach-virt
      xen/arm: implement HYPERVISOR_vcpu_op
      xenvm: add a simple PSCI node and a second cpu
      [RFC] arm: use PSCI if available

 arch/arm/boot/dts/xenvm-4.2.dts      |   12 +++++++
 arch/arm/include/asm/psci.h          |    1 +
 arch/arm/include/asm/xen/hypercall.h |    1 +
 arch/arm/kernel/psci.c               |   42 ++++++++++++++++++++++--
 arch/arm/kernel/smp.c                |    7 +++-
 arch/arm/mach-vexpress/v2m.c         |    1 -
 arch/arm/mach-virt/Makefile          |    1 -
 arch/arm/mach-virt/platsmp.c         |   58 ----------------------------------
 arch/arm/mach-virt/virt.c            |    4 +--
 arch/arm/xen/enlighten.c             |   41 +++++++++++++++++++++++-
 arch/arm/xen/hypercall.S             |    1 +
 11 files changed, 99 insertions(+), 70 deletions(-)

git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git 3.9-rc3-smp-2

Cheers,

Stefano
