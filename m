From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Dec 2010 08:48:26 +0100
Subject: Git pull request: ux500-core for the v2.6.38 merge window
Message-ID: <AANLkTim7iBkvqHrraRkMfrvQJjPHVccmSh=01hZxSyu-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull:

       git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
for-rmk

This is based on your devel branch due to the dependencies on the GIC
cleanup patches, as well as dependencies on some SMP consolidation
patches hitting platsmp.c. (I tried just taking the GIC stuff but failed
due to that, if you want me to take some special approach just tell me.)

If basing this on devel is unacceptable then please
pull this instead:

       git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-core

The branch include a number of MFD patches and one input patch
that we have agreed with Samiel Ortiz and Dmitry Torokhov to try to take
through this route in order to avoid cross-subsystem dependencies and
associated trouble. They all have their Acked-by.

All patches have been sent to the list for review.
All patches except the 2 input patches and the last 5 based off
devel in for-rmk have been tested for some time in Rothwell's
linux-next.

(This will affect the platform data for DMA in the patch tracker:
I will update that patch.)

Shortlog:

Carl-Johan Irekvist (1):
      ux500: fix uncompressor UART address for U5500

Jonas Aaberg (1):
      ux500: platsmp: Fix section mismatch

Linus Walleij (3):
      ux500: use _cansleep GPIO functions
      ux500: minor revision to the eMMC/SD config
      ux500: rename modem IRQ and MBOX files

Martin Persson (2):
      ux500: Add prcmu support for operating points
      ux500: Add cpufreq support for u8500

Mattias Wallin (2):
      ARM: ux500: prcmu db8500 v2 support
      mach-ux500: AB8500 irqs is taken from header file

Per Forlin (3):
      ux500: Call prmcu_init only for u8500
      ux500: Add eMMC support in U5500.
      ux500: Add DMA support for U5500

Rabin Vincent (12):
      ux500: mop500: add TC35892 and MicroSD slot support
      ux500: rework device registration
      nomadik-gpio: allow sleep mode dir/pull to differ from normal mode
      nomadik-gpio: use dev name if no name is specified
      ux500: rework gpio registration
      ux500: remove ambiguous irq macros
      ux500: fix 5500 PER6 clock rate
      ux500: remove build-time changing macros
      ux500: rename MOP board Kconfig
      ux500: dynamic SOC detection
      ux500: modem_irq is only for 5500
      ux500: allow 5500 and 8500 to be built together

Samuel Ortiz (1):
      mfd: Use dummy_irq_chip for tc3589x

Sundar Iyer (14):
      mach-ux500: explicit enable MTU TCR in the kernel
      mach-ux500: clean up checkpatch spits
      mach-ux500: deprecate spi support for ab8500
      mfd/tc35892: rename tc35892 header to tc3589x
      mfd/tc35892: rename tc35892 core driver to tc3589x
      mfd/tc3589x: rename tc35892 structs/registers to tc359x
      mfd/tc3589x: add block identifier for multiple child devices
      mfd/tc3589x: fix random interrupt misses
      mfd/tc3589x: undo gpio module reset during chip init
      mfd/tc3589x: add suspend/resume support
      mach-ux500: move keymaps to new file
      mach-ux500: add STMPE1601 platform data
      input/tc3589x: add tc3589x keypad support
      ux500: add TC35893 keypad platform data

Vincent Guittot (1):
      ux500: add debugfs support for powerdebug

Yours,
Linus Walleij
