From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 15:45:52 +0800
Subject: [PATCH 0/3] Enable SCU standby support at core level
Message-ID: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With SCU standby support, SCU CLK will be turned off when all processors
are in WFI mode.  And the clock will be turned on when any processor
leaves WFI mode.  This behavior should be preferable in terms of power
efficiency of system idle.

The patch series enables SCU standby support in SCU core function
scu_enable(), and then clean up the SCU standby enabling code at i.MX
platform level.

Shawn Guo (3):
  ARM: smp_scu: use macro for SCU enable bit
  ARM: smp_scu: enable SCU standby support
  ARM: imx: remove SCU standby enable code

 arch/arm/kernel/smp_scu.c         |  6 ++++--
 arch/arm/mach-imx/common.h        |  2 --
 arch/arm/mach-imx/cpuidle-imx6q.c |  4 ----
 arch/arm/mach-imx/platsmp.c       | 10 ----------
 4 files changed, 4 insertions(+), 18 deletions(-)

-- 
1.9.1
