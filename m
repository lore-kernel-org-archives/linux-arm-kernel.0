From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:45:23 +0800
Subject: [PATCH 0/6] AT91 pm improvement for 3.21
Message-ID: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch series purpose is to improve the AT91 pm code.
	Create a special procedure to handle the sdram self-fresh mode.
	The standby mode uses the same sram function as the memory mode,

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
  pm: at91: remove the at91_xxx_standby() function definitions

 arch/arm/mach-at91/Makefile       |    2 +-
 arch/arm/mach-at91/pm.c           |  151 +++++++++---------
 arch/arm/mach-at91/pm.h           |   99 +-----------
 arch/arm/mach-at91/pm_slowclock.S |  263 ------------------------------
 arch/arm/mach-at91/pm_suspend.S   |  317 +++++++++++++++++++++++++++++++++++++
 5 files changed, 396 insertions(+), 436 deletions(-)
 delete mode 100644 arch/arm/mach-at91/pm_slowclock.S
 create mode 100644 arch/arm/mach-at91/pm_suspend.S

-- 
1.7.9.5
