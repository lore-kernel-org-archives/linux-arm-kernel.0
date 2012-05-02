From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2012 12:23:54 +0200
Subject: [GIT PULL] ux500-core for ARM SoC
In-Reply-To: <201204302141.08186.arnd@arndb.de>
References: <1335369056-5331-1-git-send-email-linus.walleij@linaro.org>
 <201204302141.08186.arnd@arndb.de>
Message-ID: <CACRpkdY92StLhPv4kpopf8JpU1+PtjrgrdFWdvP4F3fwp1-_Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 11:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Please separate this into more logical branches, e.g.
>
> 1. delete u5500
> 2. add u9540 support

The U9540 stuff was used as a base so when deleting U5500 and
this code is in close hamming-proximity so you will get
a lot of conflicts.

But I've split it now so you can enjoy it ;-)
Here are these two:


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-del-u5500-for-arm-soc

for you to fetch changes up to 72fb92200d6c31b9982c06784e4bcff2f5b7d8b6:

  mfd/ab5500: delete AB5500 support (2012-05-02 00:39:55 +0200)

----------------------------------------------------------------
Linus Walleij (3):
      ARM: ux500: delete U5500 support
      mfd/db5500-prcmu: delete DB5500 PRCMU support
      mfd/ab5500: delete AB5500 support

 arch/arm/mach-ux500/Kconfig                        |   25 -
 arch/arm/mach-ux500/Makefile                       |    5 -
 arch/arm/mach-ux500/board-u5500-sdi.c              |   74 -
 arch/arm/mach-ux500/board-u5500.c                  |  162 ---
 arch/arm/mach-ux500/cache-l2x0.c                   |    4 +-
 arch/arm/mach-ux500/clock.c                        |   12 +-
 arch/arm/mach-ux500/cpu-db5500.c                   |  247 ----
 arch/arm/mach-ux500/cpu.c                          |    8 +-
 arch/arm/mach-ux500/devices-db5500.h               |   99 --
 arch/arm/mach-ux500/dma-db5500.c                   |  137 --
 arch/arm/mach-ux500/include/mach/db5500-regs.h     |  143 --
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    4 -
 arch/arm/mach-ux500/include/mach/devices.h         |    1 -
 arch/arm/mach-ux500/include/mach/hardware.h        |    1 -
 .../arm/mach-ux500/include/mach/irqs-board-u5500.h |   21 -
 arch/arm/mach-ux500/include/mach/irqs-db5500.h     |  113 --
 arch/arm/mach-ux500/include/mach/irqs.h            |    5 -
 arch/arm/mach-ux500/include/mach/mbox-db5500.h     |   88 --
 arch/arm/mach-ux500/include/mach/setup.h           |    6 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |    7 +-
 arch/arm/mach-ux500/mbox-db5500.c                  |  565 --------
 arch/arm/mach-ux500/modem-irq-db5500.c             |  143 --
 arch/arm/mach-ux500/pins-db5500.h                  |  620 ---------
 arch/arm/mach-ux500/platsmp.c                      |    8 +-
 arch/arm/mach-ux500/ste-dma40-db5500.h             |  135 --
 arch/arm/mach-ux500/timer.c                        |   13 +-
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/mfd/Kconfig                                |   27 -
 drivers/mfd/Makefile                               |    3 -
 drivers/mfd/ab5500-core.c                          | 1439 --------------------
 drivers/mfd/ab5500-debugfs.c                       |  807 -----------
 drivers/mfd/ab5500-debugfs.h                       |   22 -
 drivers/mfd/db5500-prcmu.c                         |  451 ------
 include/linux/mfd/abx500.h                         |    5 +-
 include/linux/mfd/abx500/ab5500.h                  |  140 --
 include/linux/mfd/db5500-prcmu.h                   |  105 --
 include/linux/mfd/dbx500-prcmu.h                   |  242 +---
 37 files changed, 56 insertions(+), 5833 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-u5500-sdi.c
 delete mode 100644 arch/arm/mach-ux500/board-u5500.c
 delete mode 100644 arch/arm/mach-ux500/cpu-db5500.c
 delete mode 100644 arch/arm/mach-ux500/devices-db5500.h
 delete mode 100644 arch/arm/mach-ux500/dma-db5500.c
 delete mode 100644 arch/arm/mach-ux500/include/mach/db5500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/irqs-board-u5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/irqs-db5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/mbox-db5500.h
 delete mode 100644 arch/arm/mach-ux500/mbox-db5500.c
 delete mode 100644 arch/arm/mach-ux500/modem-irq-db5500.c
 delete mode 100644 arch/arm/mach-ux500/pins-db5500.h
 delete mode 100644 arch/arm/mach-ux500/ste-dma40-db5500.h
 delete mode 100644 drivers/mfd/ab5500-core.c
 delete mode 100644 drivers/mfd/ab5500-debugfs.c
 delete mode 100644 drivers/mfd/ab5500-debugfs.h
 delete mode 100644 drivers/mfd/db5500-prcmu.c
 delete mode 100644 include/linux/mfd/abx500/ab5500.h
 delete mode 100644 include/linux/mfd/db5500-prcmu.h


And here is U9540:


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-u9540-for-arm-soc

for you to fetch changes up to ee9581d7adaeb2d04b01e3567e2355ceb5f43ad1:

  ARM: ux500: ioremap differences for DB9540 (2012-05-02 00:25:20 +0200)

----------------------------------------------------------------
Linus Walleij (1):
      ARM: ux500: core U9540 support

Michel Jaouen (1):
      ARM: ux500: ioremap differences for DB9540

 arch/arm/mach-ux500/board-mop500-uib.c         |    2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   16 +++++++++++++---
 arch/arm/mach-ux500/clock.c                    |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c               |   24 ++++++++++++++++++++----
 arch/arm/mach-ux500/cpu.c                      |    4 ++--
 arch/arm/mach-ux500/id.c                       |    9 +++++++--
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    6 ++++++
 arch/arm/mach-ux500/include/mach/hardware.h    |    3 +++
 arch/arm/mach-ux500/include/mach/id.h          |   17 ++++++++++++++++-
 arch/arm/mach-ux500/include/mach/irqs.h        |    2 +-
 arch/arm/mach-ux500/platsmp.c                  |    4 ++--
 arch/arm/mach-ux500/timer.c                    |    2 +-
 drivers/cpufreq/db8500-cpufreq.c               |    2 +-
 13 files changed, 74 insertions(+), 19 deletions(-)


> 3. device tree patches (why not in the other branch?)

OK I've rebased these onto the previously pulled branch,
so this should be an incremental pull on top of your existing
ux500 devicetree branch (or you can throw away the old one
and pull just this one):


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-devicetree-for-arm-soc

for you to fetch changes up to c51423fc067b00d8c8bd0e4e7bc861bf9050511d:

  ARM: ux500: Enable PRCMU Timer 4 (clocksource) for Device Tree
(2012-05-02 00:43:14 +0200)

----------------------------------------------------------------
Lee Jones (13):
      ARM: ux500: Rename the DT compatible entry for i2c devices on Snowball
      ARM: ux500: Shorten Snowball's DT compatible gpio entry
      ARM: ux500: Enable the external bus with Device Tree
      drivers/gpio: gpio-nomadik: Device Tree bindings
      drivers/gpio: gpio-nomadik: Provide documentation for Device Tree bindings
      ARM: ux500: Rename gpio_keys in the Device Tree file
      drivers/gpio: represent gpio-nomadik as an IRQ controller in DT
documentation
      ARM: ux500: Enable the SMSC9115 on Snowball via Device Tree
      ARM: ux500: Configure the PRCMU Timer for db8500 based devices in DT
      ARM: ux500: Do not attempt to register non-existent i2c devices
on Snowball
      ARM: ux500: Fork cpu-db8500 platform_devs for sequential DT enablement
      ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
      ARM: ux500: Enable PRCMU Timer 4 (clocksource) for Device Tree

 .../devicetree/bindings/gpio/gpio-nmk.txt          |   31 ++++++++++
 arch/arm/boot/dts/db8500.dtsi                      |   63 +++++++++++++++-----
 arch/arm/boot/dts/snowball.dts                     |   40 +++++++------
 arch/arm/mach-ux500/board-mop500.c                 |   31 +++++-----
 arch/arm/mach-ux500/cpu-db8500.c                   |   18 +++++-
 arch/arm/mach-ux500/timer.c                        |   24 ++++++++
 6 files changed, 155 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-nmk.txt


And you forgot:
4. Ux500 cpuidle
so here is yet one more:

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-cpuidle-for-arm-soc

for you to fetch changes up to 3ebabaa534c79a54c11a4ec1a81e62b76a4ada0c:

  ARM: ux500: add the cpuidle driver for WFI and ARM retention
(2012-05-02 00:44:38 +0200)

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: ux500: add the cpuidle driver for WFI and ARM retention

 arch/arm/mach-ux500/Makefile  |    1 +
 arch/arm/mach-ux500/cpuidle.c |  171 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 arch/arm/mach-ux500/cpuidle.c


Linus Walleij
