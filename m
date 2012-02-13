From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 13 Feb 2012 18:49:40 +0100
Subject: [GIT PULL] at91: fixes for 3.3-rc4
Message-ID: <4F394D34.6000604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

Here is the second "fixes" pull request. It collects a simple #ifdef fix, the
proper use of ioremap() in the RTC driver and a set of SMC related
modifications.
The SMC has been modified recently and has broken the pata_at91 driver. The
new accessors are fixing this situation. Finally, the old at91_ide driver is
removed because it is not maintained anymore, the IDE tree is frozen and PATA
should be used instead.

I have also verified that it merges correctly with depends/rmk/for-armsoc and all
at91 related 3.4 material...

You can find all this here:

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git at91-fixes

for you to fetch changes up to cf844751fb25e095d8fa30332cb173a73e5a736c:

  ARM: at91: drop ide driver in favor of the pata one (2012-02-13 18:31:37 +0100)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (4):
      ARM: at91:rtc/rtc-at91sam9: ioremap register bank
      ARM: at91: add accessor to manage SMC
      pata/at91: use newly introduced SMC accessors
      ARM: at91: drop ide driver in favor of the pata one

Nicolas Ferre (1):
      ARM: at91: USB AT91 gadget registration for module

 arch/arm/mach-at91/at91rm9200_devices.c        |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c       |    9 +-
 arch/arm/mach-at91/at91sam9261_devices.c       |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c       |    8 +-
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   29 ++
 arch/arm/mach-at91/sam9_smc.c                  |   76 +++++-
 arch/arm/mach-at91/sam9_smc.h                  |   23 --
 drivers/ata/pata_at91.c                        |   48 ++--
 drivers/ide/Makefile                           |    1 -
 drivers/ide/at91_ide.c                         |  366 ------------------------
 drivers/rtc/rtc-at91sam9.c                     |   13 +-
 11 files changed, 140 insertions(+), 437 deletions(-)
 delete mode 100644 drivers/ide/at91_ide.c

Thanks a lot, best regards,
-- 
Nicolas Ferre
