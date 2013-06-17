From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Jun 2013 10:45:14 +0100
Subject: [PATCH 0/2] arm: move HAVE_ARM_ARCH_TIMER selects into multi_v7
 platforms
Message-ID: <1371462316-9201-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The multi_v7_defconfig used to select ARM_ARCH_TIMER, but was broken by
8a4da6e36c: "arm: arch_timer: move core to drivers/clocksource". Since
then some platforms haven't been getting the architected timer support
they want when building from a multi_v7_defconfig.

As not all platforms require architected timer support, rather than
selecting it in the multi_v7_defconfig, this patch adds selects to the
platforms requiring support.

Thanks,
Mark.

Mark Rutland (2):
  arm: vexpress: select HAVE_ARM_ARCH_TIMER
  arm: highbank: select HAVE_ARM_ARCH_TIMER

 arch/arm/mach-highbank/Kconfig | 1 +
 arch/arm/mach-vexpress/Kconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
1.8.1.1
