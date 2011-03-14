From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Mar 2011 12:46:14 +0100
Subject: [GIT PULL] u300, ux500 and Nomadik changes for v2.6.39
In-Reply-To: <20110313214835.GA24370@n2100.arm.linux.org.uk>
References: <AANLkTikgMq4QbRGZ_3kkzeNBp9aD4YKa-0CRCfs1K57u@mail.gmail.com>
	<20110313214835.GA24370@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinjp4HDu7+hKXP7X2ELBrNAuVc4LXVBiRn720yj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 13, 2011 at 10:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I'm intending sending some of these branches as entirely separate pulls
> to Linus - particularly the defconfig and devel-stable branches (so that
> Linus can see what code outside arch/arm is being modified by other
> people and target his complaints about that more appropriately).
>
> Merging your tree is going to destroy my ability to keep this stuff
> strictly separate.

Aha I get it... The defconfig can wait for sure.

> I don't mind merging the ux500 branch into devel-stable provided you're
> not going to send any further ux500 patches?

No hurries atleast. We have some minor drivers pending but I will request
subsystems to take the bulk of these drivers and have the platform data
come in the next merge window or directly to Torvalds.

I created a branch named "for-rmk-devel-stable" without the defconfig stuff,
that lands entirely inside the arch/arm/* tree, it duplicates the two PMU
patches and nothing else from your tree:
      ARM: perf_event: allow platform-specific interrupt handler
      mach-ux500: DB8500 PMU support

The following changes since commit dd9c1549edef02290edced639f67b54a25abbe0e:

  Linux 2.6.38-rc7 (2011-03-01 13:55:12 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
for-rmk-devel-stable

Bibek Basu (1):
      mach-ux500: add hrefv60 GPIO pins

Jonas Aaberg (1):
      plat-nomadik: pull-up/down settings for GPIO resume

Lee Jones (1):
      mach-ux500: Add Rohm BH1780GLI Light Sensor to i2c_board_info

Linus Walleij (9):
      mach-ux500: add DB5500 PMU resources
      mach-ux500: add a few AB8500 regulator consumers v3
      mach-ux500: delete old keypad board file
      mach-u300: use mmci driver for GPIO card detect
      mach-u300: config U300 PL180 PL011 PL022 for DMA
      mach-ux500: config Ux500 PL011 PL022 PL180 for DMA
      plat-nomadik: fix compilation warning
      mach-ux500: basic HREFv60 support v2
      mach-u300: define a dummy filter function for coh901318

Mian Yousaf Kaukab (4):
      mach-ux500: add platform data for musb
      mach-ux500: update MUSB clock configurations
      mach-ux500: add MUSB to db8500 devices
      mach-ux500: add MUSB to db5500 devices

Philippe Langlais (4):
      mach-ux500: platform data for SFH7741 proximity sensor driver
      mach-ux500: platform data for LP5521 leds driver
      mach-ux500: set sd/mmc clock rate to 100MHz
      mach-ux500: fix inverted SD-card GPIO pin

Rabin Vincent (12):
      ARM: perf_event: allow platform-specific interrupt handler
      mach-ux500: DB8500 PMU support
      mach-ux500: dynamic UIB (user interface boards) detection
      plat-nomadik: support varying number of GPIOs per block
      plat-nomadik: add custom dbg_show for GPIO
      plat-nomadik: implement suspend/resume for GPIO
      plat-nomadik: support secondary GPIO interrupts
      plat-nomadik: set altfunc to GPIO when enabling the sleep config
      plat-nomadik: implement safe switch sequence for Alt-C
      plat-nomadik: get rid of unused GPIO PM code
      mach-ux500: move MOP500 pins to separate file
      plat-nomadik: make GPIO interrupts work with cpuidle ApSleep

Rikard Olsson (1):
      plat-nomadik: change sleep/wakeup setting in GPIO SLPM register

Sundar Iyer (3):
      mach-ux500: fix ux500 build error
      mach-ux500: add ST-UIB platform data
      mach-ux500: add U8500 UIB platform data

Virupax Sadashivpetimath (1):
      plat-nomadik: type secondary IRQ correctly

 arch/arm/include/asm/pmu.h                    |   14 +
 arch/arm/kernel/perf_event.c                  |   17 +-
 arch/arm/mach-u300/core.c                     |  179 ++++++++-
 arch/arm/mach-u300/include/mach/coh901318.h   |    7 +
 arch/arm/mach-u300/mmc.c                      |  160 ++-------
 arch/arm/mach-u300/spi.c                      |   21 +-
 arch/arm/mach-ux500/Makefile                  |    8 +-
 arch/arm/mach-ux500/board-mop500-keypads.c    |  229 ------------
 arch/arm/mach-ux500/board-mop500-pins.c       |  241 ++++++++++++
 arch/arm/mach-ux500/board-mop500-regulators.c |   62 ++++
 arch/arm/mach-ux500/board-mop500-sdi.c        |  184 ++++++----
 arch/arm/mach-ux500/board-mop500-stuib.c      |  205 +++++++++++
 arch/arm/mach-ux500/board-mop500-u8500uib.c   |  111 ++++++
 arch/arm/mach-ux500/board-mop500-uib.c        |  135 +++++++
 arch/arm/mach-ux500/board-mop500.c            |  328 ++++++++++++++----
 arch/arm/mach-ux500/board-mop500.h            |   25 ++-
 arch/arm/mach-ux500/board-u5500-sdi.c         |   25 ++
 arch/arm/mach-ux500/board-u5500.c             |    6 +-
 arch/arm/mach-ux500/clock.c                   |    6 +-
 arch/arm/mach-ux500/cpu-db5500.c              |   53 +++-
 arch/arm/mach-ux500/cpu-db8500.c              |   76 ++++-
 arch/arm/mach-ux500/devices-common.c          |    1 +
 arch/arm/mach-ux500/devices-common.h          |    7 +-
 arch/arm/mach-ux500/devices-db5500.h          |   19 +-
 arch/arm/mach-ux500/devices-db8500.c          |   67 ++++-
 arch/arm/mach-ux500/devices-db8500.h          |   15 +-
 arch/arm/mach-ux500/dma-db5500.c              |   16 +
 arch/arm/mach-ux500/include/mach/uncompress.h |    6 +-
 arch/arm/mach-ux500/include/mach/usb.h        |   25 ++
 arch/arm/mach-ux500/usb.c                     |  160 ++++++++
 arch/arm/plat-nomadik/gpio.c                  |  487 +++++++++++++++++++++----
 arch/arm/plat-nomadik/include/plat/gpio.h     |    6 +
 32 files changed, 2269 insertions(+), 632 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-keypads.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-pins.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-stuib.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-u8500uib.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-uib.c
 create mode 100644 arch/arm/mach-ux500/include/mach/usb.h
 create mode 100644 arch/arm/mach-ux500/usb.c

Yours,
Linus Walleij
