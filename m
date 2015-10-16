From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 16 Oct 2015 17:33:31 +0100
Subject: [PATCH v2] xen,arm: enable cpu_hotplug
Message-ID: <alpine.DEB.2.02.1510161731510.27957@kaball.uk.xensource.com>
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

 arch/arm/include/asm/xen/hypervisor.h |   10 ++++++++++
 arch/arm/xen/enlighten.c              |   10 ++++++++++
 arch/x86/include/asm/xen/hypervisor.h |    5 +++++
 arch/x86/xen/enlighten.c              |   15 +++++++++++++++
 drivers/xen/Makefile                  |    2 --
 drivers/xen/cpu_hotplug.c             |   11 ++++++++---
 6 files changed, 48 insertions(+), 5 deletions(-)

Cheers,

Stefano
