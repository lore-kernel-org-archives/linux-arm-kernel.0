From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 23 Dec 2010 09:49:43 -0800
Subject: [GIT PULL] davinci updates for 2.6.38
Message-ID: <87tyi4js5k.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following changes for the TI DaVinci family of SoCs for
the 2.6.38 merge window.

Thanks,

Kevin


The following changes since commit cf7d7e5a1980d1116ee152d25dac382b112b9c17:

  Linux 2.6.37-rc5 (2010-12-06 20:09:04 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git davinci-next

Andreas Gaeer (1):
      davinci: Implement sched_clock()

Ben Gardiner (7):
      davinci: da850-evm: UI expander gpio_set_value can sleep, use _cansleep
      da850-evm: allow pca953x module build
      da850-evm, trivial: use da850_evm prefix for consistency
      da850-evm: add UI Expander pushbuttons
      da850-evm: extract defines for SEL{A,B,C} pins in UI expander
      da850-evm: add baseboard GPIO expander buttons, switches and LEDs
      da850-evm: KEYBOARD_GPIO_POLLED Kconfig conditional

Cyril Chemparathy (2):
      davinci: use divide ratio limits from pll_data
      davinci: minor tnetv107x clock tree fixes

Kevin Hilman (1):
      davinci: kconfig: select at24 eeprom for selected boards

Nicolas Kaiser (2):
      davinci: psc: simplify if-statement
      davinci: aemif: signedness bug in davinci_aemif_setup_timing()

Sekhar Nori (2):
      davinci: am18x/da850/omap-l138: add support for higher speed grades
      davinci: am18x/da850/omap-l138 evm: add support for higher speed grades

 arch/arm/mach-davinci/Kconfig              |   19 ++-
 arch/arm/mach-davinci/aemif.c              |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c    |  339 ++++++++++++++++++++++++++--
 arch/arm/mach-davinci/clock.c              |    4 +-
 arch/arm/mach-davinci/da850.c              |   75 +++++--
 arch/arm/mach-davinci/devices-tnetv107x.c  |   15 ++-
 arch/arm/mach-davinci/include/mach/da8xx.h |    7 +
 arch/arm/mach-davinci/psc.c                |   13 +-
 arch/arm/mach-davinci/time.c               |   24 ++-
 arch/arm/mach-davinci/tnetv107x.c          |   23 +-
 10 files changed, 462 insertions(+), 59 deletions(-)
