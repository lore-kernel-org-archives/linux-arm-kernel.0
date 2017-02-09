From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2017 12:17:57 +0000
Subject: [PATCH 0/4] kuser updates for ARM-only vs Thumb
Message-ID: <20170209121756.GC27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A while back, an issue was raised about the return instruction used
in the kuser page when building an ARMv4 and later environment.

In order to fix this, I suggested building the kuser code for both
variants and selecting the appropriate version at run time.  This
seemed to be a simple solution, but due to the fix-ups and need to
build the appropriate version for the Kconfig options selected,
turned out to be not quite as trivial as I hoped.

Nevertheless, this patch series provides that solution.

As a side effect of this, the first patch is one which should be
merged irrespective of the remainder as it provides a useful cleanup
to the large number of dependencies for the ARM_THUMB option.

 arch/arm/kernel/Makefile     |  10 +++
 arch/arm/kernel/entry-armv.S | 198 -------------------------------------------
 arch/arm/kernel/kuser-t.S    |  13 +++
 arch/arm/kernel/kuser-v4.S   |  11 +++
 arch/arm/kernel/kuser.S      | 196 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c      |  37 +++++++-
 arch/arm/mm/Kconfig          |  31 +++++--
 7 files changed, 289 insertions(+), 207 deletions(-)
 create mode 100644 arch/arm/kernel/kuser-t.S
 create mode 100644 arch/arm/kernel/kuser-v4.S
 create mode 100644 arch/arm/kernel/kuser.S

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
