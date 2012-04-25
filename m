From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Apr 2012 18:05:29 +0200
Subject: [GIT PULL] ux500 GPIO and pins for ARM SoC
Message-ID: <1335369929-5856-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM SoC maintainers,

This is a pull request for the GPIO and pin control stuff
accumulated in the ST-Ericsson tree. Here we have:

- - Improvements and fixes and a custom pin config API from
  Rabin Vincent

- - Device Tree bindings from Lee Jones

- - Some accumulated patches by yours truly.

- - A MSP platform data init patch from Ola Lilja that is merged
  here due to dependency on pin config work. It is to be
  used with work being worked on in parallel in the ALSA
  SoC subsystem.

If you wonder about the custom pin config implementation this
is to be used as a transition base as I am rewriting the
driver to use pinctrl. Expect a final pull request on top
of this one that will move the ux500 over to pinctrl.

Please pull this in...

Yours,
Linus Walleij


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-gpio-pins-for-arm-soc

Lee Jones (2):
      drivers/gpio: gpio-nomadik: Apply Device Tree bindings
      drivers/gpio: gpio-nomadik: Add support for irqdomains

Linus Walleij (4):
      gpio/nomadik: use ioremap() instead of static mappings
      plat-nomadik: new sleep mode pincfg macros
      ARM: ux500: remove a bunch of internal pull-ups
      ARM: ux500: update pin handling

Ola Lilja (1):
      ARM: ux500: Add support for MSP I2S-devices

Rabin Vincent (5):
      gpio/nomadik: don't set SLPM to 1 for non-wakeup pins
      gpio/nomadik: cache [rf]w?imsc
      gpio/nomadik: fix spurious interrupts with SKE
      gpio/nomadik: support low EMI mode
      ARM: ux500: implement pin API

 arch/arm/mach-ux500/Makefile                      |    5 +-
 arch/arm/mach-ux500/board-mop500-msp.c            |  250 +++++++++++++
 arch/arm/mach-ux500/board-mop500-msp.h            |   14 +
 arch/arm/mach-ux500/board-mop500-pins.c           |  394 ++++++++++++++++-----
 arch/arm/mach-ux500/board-mop500.c                |   16 +
 arch/arm/mach-ux500/board-mop500.h                |    4 +
 arch/arm/mach-ux500/clock.c                       |    8 +-
 arch/arm/mach-ux500/cpu.c                         |   12 +
 arch/arm/mach-ux500/devices-db8500.h              |   10 -
 arch/arm/mach-ux500/include/mach/msp.h            |   29 ++
 arch/arm/mach-ux500/pins-db8500.h                 |   72 ++--
 arch/arm/mach-ux500/pins.c                        |   88 +++++
 arch/arm/mach-ux500/pins.h                        |   46 +++
 arch/arm/plat-nomadik/include/plat/gpio-nomadik.h |    1 +
 arch/arm/plat-nomadik/include/plat/pincfg.h       |   19 +
 drivers/gpio/gpio-nomadik.c                       |  285 +++++++++++-----
 16 files changed, 1023 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h
 create mode 100644 arch/arm/mach-ux500/pins.c
 create mode 100644 arch/arm/mach-ux500/pins.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmCCYAAoJEEEQszewGV1zIn0QAJO8C7k2Ax85NLLIoK6nFOEb
g8pk0gN8x92y74Jl9o/8dZI+Cqlv2F5huqR8IAISoWb8ioIdyoh3LX0l1z1yAtj5
iJ9vBq6Q/vyuslynoRnJcDFVeFM4RNIWzgrsrkugMXKGhiHYnz4ro9DqJ1G8gLLW
+5hH+rg21sv/L5ud6y4wfeTtsJeK2al8l/zdZYAW4tnG+05VUqBRaD8hiUS2qAgS
GWpWhh3+B785vhmRSUQk9DhJ+xbQtdop9JjBrpmlJwfZQchm7/h5dj5UAANcLs5a
PWX//zToak0x/PWjC1wFsSTDvENZN98pPfRK72BQXhIqN6jFQbS6Ce6Iu5L79R2c
ug//UfnN4V/PVGHQh3J9ApM4xcHgjCrpLC3nUmIPKP5KQgqLlVF5OHEtFPUxE/Pa
k7xX2hkfcpjgn+XfIQ+wSZQkG4Cr830XNt2eHkydfDFXXnE5SsYP7cdA+1nWKl//
Vmu8wKV29DGZwef1r2jU3cGnDUX4owTVGsf/kYJvP02lafb3NA0rxygjxGfKo1Ni
AzlZJarpcML7RSK7SoxF6zENKVOrbnjIt0aB7bswzafSvLdF8bCuqW50nbj3wu+m
ktiA4fhjzwxdo6UcxmS/0B4jn9dfoOsfF+9ZA4P6EfHZXQDCLFG49oZJn9wxQnbv
VIOZfTs72SnkzLzZhpHj
=lmn4
-----END PGP SIGNATURE-----
