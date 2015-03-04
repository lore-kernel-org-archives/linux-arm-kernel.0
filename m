From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 11:51:45 +0100
Subject: [GIT PULL] at91: fixes for 4.0 #1
Message-ID: <1425466305-25150-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is the first batch of fixes for 4.0. Several topics covered like PM, DT or
defconfig. The watchdog option removal is the most important one.

Thanks, best regards,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to 2141102e045e622cac176891cb66c5bf08e439f5:

  ARM: at91/dt: keep watchdog running in idle mode (2015-03-04 11:20:52 +0100)

----------------------------------------------------------------
First fixes batch for AT91 on 4.0:
- PM slowclock fixes for DDR and timeouts
- fix some DT entries
- little defconfig updates
- the removal of a harmful watchdog option + its detailed documentation

----------------------------------------------------------------
Alexander Stein (1):
      ARM: at91/dt: at91sam9263: Fixup sram1 device tree node

Alexandre Belloni (3):
      ARM: at91: pm: fix at91rm9200 standby
      ARM: at91: pm: fix SRAM allocation
      ARM: at91/defconfig: add at91rm9200 ethernet support

Anthony Harivel (1):
      ARM: at91/defconfig: remove CONFIG_SYSFS_DEPRECATED

Jonas Andersson (1):
      ARM: at91/dt: at91sam9260: fix usart pinctrl

Michel Marti (1):
      ARM: at91/dt: keep watchdog running in idle mode

Nicolas Ferre (1):
      ARM: at91/dt: sama5d4: add missing alias for i2c0

Peter Rosin (1):
      pm: at91: Workaround DDRSDRC self-refresh bug with LPDDR1 memories.

Sylvain Rochet (2):
      pm: at91: pm_slowclock: fix suspend/resume hang up in timeouts
      dts: Documentation: AT91 Watchdog, explain what atmel,idle-halt property really do

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  5 ++
 arch/arm/boot/dts/at91sam9260.dtsi                 |  5 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  3 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  1 -
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  1 -
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  1 -
 arch/arm/boot/dts/sama5d3.dtsi                     |  1 -
 arch/arm/boot/dts/sama5d4.dtsi                     |  1 +
 arch/arm/configs/at91_dt_defconfig                 |  1 +
 arch/arm/configs/sama5_defconfig                   |  2 -
 arch/arm/mach-at91/pm.c                            | 22 +++----
 arch/arm/mach-at91/pm.h                            |  2 +-
 arch/arm/mach-at91/pm_slowclock.S                  | 76 ++++++++++++----------
 include/soc/at91/at91sam9_ddrsdr.h                 |  2 +-
 14 files changed, 64 insertions(+), 59 deletions(-)

-- 
Nicolas Ferre
