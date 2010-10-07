From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 07 Oct 2010 19:55:38 +0200
Subject: [GITT PULL] AT91 for 2.6.37 merge window
Message-ID: <4CAE099A.6080807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Could you please pull the following:

  git://github.com/at91linux/linux-2.6-at91.git for_rmk

This contains AT91 update for 2.6.37 merge window. All has been discussed on
the list. 

It if based on linus' tree 2.6.36-rc7 commit cb655d0f3d57c23db51b981648e452988c0223f9


David,

The tiny patch that affects "drivers/net/Kconfig" is pending since beginning of August, I propose to include it through ARM tree as it should not create any merging issue.


Greg Ungerer (1):
      AT91: fix use of clock disable on idle for AT91x40 devices

Jean-Christophe PLAGNIOL-VILLARD (3):
      AT91: at91sam9m10g45ek: use the right machine id
      AT91: at91sam9g20ek: merge 2mmc version in one board
      net: atmel_macb Kconfig: remove long dependency line

Nicolas Ferre (1):
      AT91: Correct configuration define value

 arch/arm/configs/at91sam9g20ek_defconfig       |    1 +
 arch/arm/mach-at91/Kconfig                     |    9 +-
 arch/arm/mach-at91/Makefile                    |    3 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c |  329 ------------------------
 arch/arm/mach-at91/board-sam9g20ek.c           |   74 +++++-
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    4 +-
 arch/arm/mach-at91/include/mach/at91x40.h      |    6 +
 arch/arm/mach-at91/include/mach/system.h       |    4 +
 arch/avr32/Kconfig                             |    1 +
 drivers/net/Kconfig                            |    5 +-
 11 files changed, 95 insertions(+), 343 deletions(-)
 delete mode 100644 arch/arm/mach-at91/board-sam9g20ek-2slot-mmc.c

Thanks a lot, best regards,
-- 
Nicolas Ferre
