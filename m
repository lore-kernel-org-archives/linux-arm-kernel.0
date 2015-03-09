From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:47:37 +0800
Subject: [PATCH v2.0 0/6] ARM: AT91: pm improvement for 4.1
Message-ID: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch series purpose is to improve the AT91 pm code.
	Create a procedure to handle the sdram self-fresh mode.
	The standby mode uses same sram function as the suspend to memory mode,

It is based on the branch, at91-4.0-fixes
git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
	+ [PATCH] ARM: AT91: pm cleanup for 4.1

Chang log for v2.0
 - reserve the at91_xxx_standby() for at91_cpuidle_device.
 - rebase

Wenyou Yang (6):
  pm: at91: pm_slowclock: create the procedure to handle the sdram
    self-refresh
  pm: at91: move the copying the sram function to the sram
    initializationi phase
  pm: at91: standby mode uses the same sram function as suspend to
    memory mode
  pm: at91: rename file name: pm_slowclock.S -->pm_suspend.S
  pm: at91: rename function name:
    at91_slow_clock()-->at91_pm_suspend_sram_fn
  pm: at91: remove unused void (*at91_pm_standby)(void)

 arch/arm/mach-at91/Makefile       |    2 +-
 arch/arm/mach-at91/pm.c           |  121 +++++++------
 arch/arm/mach-at91/pm.h           |   10 ++
 arch/arm/mach-at91/pm_slowclock.S |  296 -------------------------------
 arch/arm/mach-at91/pm_suspend.S   |  349 +++++++++++++++++++++++++++++++++++++
 5 files changed, 420 insertions(+), 358 deletions(-)
 delete mode 100644 arch/arm/mach-at91/pm_slowclock.S
 create mode 100644 arch/arm/mach-at91/pm_suspend.S

-- 
1.7.9.5
