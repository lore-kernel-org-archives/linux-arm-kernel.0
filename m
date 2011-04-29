From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 29 Apr 2011 17:16:51 +0200
Subject: [PATCHv4 2.6.40 0/4] ARM: simpad: Add support for GPIO attached
	hardware
Message-ID: <1304090215-7457-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables GPIO API on UCB1x00 and implements the GPIO
API on the CS3 latch. The third patch finally registers platform
devices for the GPIO attached LED, buttons and I2C bus.

v2: In response to the Linus rant, remove the ARM specific LED
    support for simpad hardware instead of supporting it
    alternatively to the generic LED code.

v3: Move LED changes into a seperate patch.

v4: Fix access to status pins in PCMCIA driver. Replace "magic
    numbers" by constants.

ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
ARM: simpad: Cleanup CS3 accessors and add GPIO API
ARM: simpad: add GPIO based device definitions
ARM: simpad: replace ARM specific LED code

Overall diffstat:

 arch/arm/mach-sa1100/Makefile              |    1 -
 arch/arm/mach-sa1100/include/mach/simpad.h |   94 ++++++++++---
 arch/arm/mach-sa1100/leds-simpad.c         |  100 -------------
 arch/arm/mach-sa1100/leds.c                |    2 -
 arch/arm/mach-sa1100/leds.h                |    1 -
 arch/arm/mach-sa1100/simpad.c              |  211 ++++++++++++++++++++++++---
 drivers/pcmcia/sa1100_simpad.c             |   35 ++---
 7 files changed, 274 insertions(+), 170 deletions(-)
