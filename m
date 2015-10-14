From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 14 Oct 2015 18:49:38 +0100
Subject: xen,arm: enable cpu_hotplug
Message-ID: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this small patch series enable cpu_hotplug in ARM and ARM64 guests,
using the PV path to plug and unplug the cpus and psci to enable/disable
them.


Stefano Stabellini (3):
      xen/arm: Enable cpu_hotplug.c
      xen, cpu_hotplug: call device_offline instead of cpu_down
      xen/arm: don't try to re-register vcpu_info on cpu_hotplug.

 arch/arm/include/asm/xen/hypervisor.h |    8 ++++++++
 arch/arm/xen/enlighten.c              |    6 ++++++
 arch/x86/include/asm/xen/hypervisor.h |    5 +++++
 arch/x86/xen/enlighten.c              |   15 +++++++++++++++
 drivers/xen/Makefile                  |    2 --
 drivers/xen/cpu_hotplug.c             |    9 ++++++---
 6 files changed, 40 insertions(+), 5 deletions(-)

Cheers,

Stefano
