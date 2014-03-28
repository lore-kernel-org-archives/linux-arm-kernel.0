From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Mar 2014 11:02:57 +0100
Subject: [GIT PULL] Versatile LEDs conversion
Message-ID: <CACRpkdb4VhN5Dt6ZoUNgwphxUD7Q69waF9vfO_=SenbvA=WSeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a Versatile LEDs patch stack, it has been finished for a while,
but delayed waiting for an ACK from the LEDs subsystem maintainer
which arrived today. (My bad for not hunting it more actively.)

I pretty sure the patches are safe and they need some rotation in linux-next,
but I understand if you want to wait until after v3.15-rc1 before pulling this
in. (I'll nag you later in that case.)

Yours,
Linus Walleij

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-leds

for you to fetch changes up to 9b58d187fdce9df05fd331ad5790bf503d7e3dfe:

  ARM: plat-versatile: update defconfigs for Versatile LEDs
(2014-03-28 10:54:31 +0100)

----------------------------------------------------------------
This contains a christmas-decoration fix from Russell
King, converts the Versatile LEDs to a platform device
and moves the driver to the LEDs subsystem.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: plat-versatile: convert LEDs to platform device
      ARM/leds: move ARM Versatile LED driver to leds subsystem
      ARM: plat-versatile: update defconfigs for Versatile LEDs

Russell King (1):
      ARM: plat-versatile: LEDs initialise to off state

 arch/arm/configs/realview-smp_defconfig            |  2 +
 arch/arm/configs/realview_defconfig                |  2 +
 arch/arm/configs/versatile_defconfig               |  3 ++
 arch/arm/mach-realview/core.c                      | 15 +++++++
 arch/arm/mach-realview/core.h                      |  1 +
 arch/arm/mach-realview/realview_eb.c               |  1 +
 arch/arm/mach-realview/realview_pb1176.c           |  1 +
 arch/arm/mach-realview/realview_pb11mp.c           |  1 +
 arch/arm/mach-realview/realview_pba8.c             |  1 +
 arch/arm/mach-realview/realview_pbx.c              |  1 +
 arch/arm/mach-versatile/core.c                     | 16 +++++++
 arch/arm/plat-versatile/Kconfig                    |  6 ---
 arch/arm/plat-versatile/Makefile                   |  1 -
 drivers/leds/Kconfig                               |  8 ++++
 drivers/leds/Makefile                              |  1 +
 .../leds.c => drivers/leds/leds-versatile.c        | 51 ++++++++++++----------
 16 files changed, 82 insertions(+), 29 deletions(-)
 rename arch/arm/plat-versatile/leds.c => drivers/leds/leds-versatile.c (68%)
