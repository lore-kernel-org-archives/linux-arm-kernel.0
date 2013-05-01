From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 1 May 2013 20:27:07 +0100
Subject: [PATCH 0/3] xen/arm: account for stolen ticks
Message-ID: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this small patch series introduces stolen ticks accounting for Xen on
ARM. Stolen ticks are clocksource ticks that have been "stolen" from the
cpu, typically because Linux is running in a virtual machine and the
vcpu has been descheduled.


Stefano Stabellini (3):
      arm_arch_timer: introduce arch_timer_stolen_ticks
      xen: move do_stolen_accounting to drivers/xen/time.c
      xen/arm: account for stolen ticks

 arch/arm/include/asm/arch_timer.h    |    5 +
 arch/arm/xen/enlighten.c             |    4 +
 arch/x86/xen/time.c                  |  127 +------------------------------
 drivers/clocksource/arm_arch_timer.c |    6 ++
 drivers/xen/Makefile                 |    2 +-
 drivers/xen/time.c                   |  142 ++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h                |    4 +
 7 files changed, 163 insertions(+), 127 deletions(-)
 create mode 100644 drivers/xen/time.c


 git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_1


Cheers,

Stefano
