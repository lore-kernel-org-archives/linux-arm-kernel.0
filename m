From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 30 Apr 2013 15:51:33 +0100
Subject: [GIT PULL] (arm/xen) 3.9-rc3-smp-6-tag
Message-ID: <alpine.DEB.2.02.1304301515490.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
this is my first pull request to you, Konrad decided to let me deal
with the Xen/ARM stuff myself recently.
Please pull the following tag (based on 3.9-rc3):

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git 3.9-rc3-smp-6-tag

It contains a bunch of Xen/ARM specific changes, including some fixes,
SMP support for Xen on ARM, and moving the xenvm machine from
mach-vexpress to mach-virt.

The non-Xen files that are touched are arch/arm/Kconfig, to select
ARM_PSCI on XEN, and arch/arm/boot/dts/Makefile, to build the xenvm DTB
if CONFIG_ARCH_VIRT.


Stefano Stabellini (7):
      xen/arm: actually pass a non-NULL percpu pointer to request_percpu_irq
      xen/arm: implement HYPERVISOR_vcpu_op
      xen/arm: SMP support
      xen: move the xenvm machine to mach-virt
      xen/arm: XEN selects ARM_PSCI
      xenvm: add a simple PSCI node and a second cpu
      xen/arm: use sched_op hypercalls for machine reboot and power off

Wei Yongjun (1):
      xen/arm: remove duplicated include from enlighten.c

 arch/arm/Kconfig                     |    1 +
 arch/arm/boot/dts/Makefile           |    4 +-
 arch/arm/boot/dts/xenvm-4.2.dts      |   13 ++++++
 arch/arm/include/asm/xen/hypercall.h |    1 +
 arch/arm/mach-vexpress/v2m.c         |    1 -
 arch/arm/mach-virt/virt.c            |    1 +
 arch/arm/xen/enlighten.c             |   74 ++++++++++++++++++++++++++++++---
 arch/arm/xen/hypercall.S             |    1 +
 8 files changed, 86 insertions(+), 10 deletions(-)


Cheers,
Stefano
