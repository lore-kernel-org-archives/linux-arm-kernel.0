From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Apr 2012 17:58:59 +0200
Subject: [GIT PULL] ux500 device tree patches
Message-ID: <1335369540-5607-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM SoC maintainers,

this pull request contains some device tree work by Lee Jones.
I have tried to keep these patches in the arch/arm/boot/dts/*
space to get some sanity in the branch proliferation.

There is still one patch that touches arch/arm/mach-ux500 too
though (but it should merge fine with the other ux500 stuff).

The changes to the device tree are of course dependent on some
core changes and some patching in the GPIO/pin driver, but as
the device tree files are believed to be a different world
(and should one day live in their own git) I split this off
anyway. I don't think people bisect the device trees per se
and the board code in conjunction anyway.

If you think differently tell me and I'll happily stack
all three pull requests on top of each other and send one
big shebang with everything instead :-)

So: please pull this in.

Yours,
Linus Walleij

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-devicetree-for-arm-soc

Lee Jones (9):
      ARM: ux500: Rename the DT compatible entry for i2c devices on Snowball
      ARM: ux500: Shorten Snowball's DT compatible gpio entry
      ARM: ux500: Enable the external bus with Device Tree
      drivers/gpio: gpio-nomadik: Device Tree bindings
      drivers/gpio: gpio-nomadik: Provide documentation for Device Tree bindings
      ARM: ux500: Rename gpio_keys in the Device Tree file
      drivers/gpio: represent gpio-nomadik as an IRQ controller in DT documentation
      ARM: ux500: Enable the SMSC9115 on Snowball via Device Tree
      ARM: ux500: Configure the PRCMU Timer for db8500 based devices in DT

 .../devicetree/bindings/gpio/gpio-nmk.txt          |   31 ++++++++++
 arch/arm/boot/dts/db8500.dtsi                      |   63 +++++++++++++++-----
 arch/arm/boot/dts/snowball.dts                     |   40 +++++++------
 arch/arm/mach-ux500/board-mop500.c                 |    5 +-
 4 files changed, 103 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-nmk.txt
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmB8QAAoJEEEQszewGV1zKtQP/RQT/vf9C6ZozqX8/l5ehTd9
Ip7O4vlYEfe0d/lJZ/TgRQKIWWgu/56y/ZNh9asoEbKJaLSjkeHUdp6hYqQ+5XcJ
92Cb5aQNbAlIV+ghkXRofulFgsOc/ZFx7HL8t4rrJZpuKGa8f6SCRYvF82FlxyCk
6ETXWLswRHS/9Xj2UUf+9XX+YQZQLHzBT8Gh/VYOO2MI8RdEpUh4hfD5VJQgQK6y
ozaABaVcLEkoZfQwYgLORLAVkTtXuUrBexj6AJ5m+IO16Apup/vlyQriDVA1lrR4
9MXGxswulAZHUSyBUAdSmw8PQ2YTpf7HMr2KaspXJoN94s4XVa1Gf8Nps6QqVe5A
0hiXIw7GuWuzT0HhN7d8q9A+Yl8FqWapmUljimpD2XABFfNc1+Mzupuwf+egWF2w
FEyw7jD86Gh/N/RWevmBoDQ746nrUBMoJoloAC1qCP5b5j6qJvIHgViy9ddTEhTy
e0LrTirzGGGiJ+3oZdYLY7Y5f0G7/KrKwdajDPw/0xSbCZj/hYGClgw/bGtcYpcN
SlUkrppfARSRPeQAs+xEPqzgwgaivsNDO5yVkTgXaOrAy3oajmTY2leegH5A0KqK
rQYeniut/ZnKywCeYpPq2SiIVgqA9QMHCnRTUouubHaPXY+SASQI0S9ShVKqAqhY
bHAp3sKpTx/nRmUQxock
=H2Ne
-----END PGP SIGNATURE-----
