From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Mon, 27 May 2013 20:02:37 +0530
Subject: [PATCH 0/8] ARM: use cpu_do_idle for entering wfi mode
Message-ID: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch set we make use of cpu_do_idle to enter WFI mode,
many platform are not clearing the data buffer before WFI or
directly using the address instead of opcode. For the rest its good
to have a common approach.

Sanjay Singh Rawat (8):
  ARM: EXYNOS: use generic cpu idle function for wfi
  ARM: RealView: use generic cpu idle function for wfi
  ARM: SPEAr: use generic cpu idle function for wfi
  ARM: vexpress: use generic cpu idle function for wfi
  ARM: zynq: use generic cpu idle function for wfi
  ARM: ux500: use generic cpu idle function for wfi
  ARM: msm: use generic cpu idle function for wfi
  ARM: PRIMA2: use generic cpu idle function for wfi

 arch/arm/mach-exynos/hotplug.c   |    9 ++-------
 arch/arm/mach-msm/hotplug.c      |    9 ++-------
 arch/arm/mach-prima2/hotplug.c   |    4 ++--
 arch/arm/mach-realview/hotplug.c |    9 ++-------
 arch/arm/mach-spear/hotplug.c    |    3 ++-
 arch/arm/mach-ux500/hotplug.c    |    5 +++--
 arch/arm/mach-vexpress/hotplug.c |    3 ++-
 arch/arm/mach-zynq/hotplug.c     |    4 ++--
 8 files changed, 17 insertions(+), 29 deletions(-)

-- 
1.7.9.5
