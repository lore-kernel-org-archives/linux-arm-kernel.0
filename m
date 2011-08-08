From: jochen@scram.de (Jochen Friedrich)
Date: Mon,  8 Aug 2011 10:49:35 +0200
Subject: [PATCH 3.2 0/4] ARM: simpad: Add support for GPIO attached hardware
Message-ID: <1312793379-6020-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables GPIO API on UCB1x00 and implements the GPIO
API on the CS3 latch. The third patch finally registers platform
devices for the GPIO attached LED, buttons and I2C bus.

ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
ARM: simpad: Cleanup CS3 accessors and add GPIO API
ARM: simpad: add GPIO based device definitions
ARM: simpad: replace ARM specific LED code

Overall diffstat:

 arch/arm/mach-sa1100/leds-simpad.c           |  100 ------------
 b/arch/arm/mach-sa1100/Makefile              |    1 
 b/arch/arm/mach-sa1100/include/mach/simpad.h |   94 +++++++++--
 b/arch/arm/mach-sa1100/leds.c                |    2 
 b/arch/arm/mach-sa1100/leds.h                |    1 
 b/arch/arm/mach-sa1100/simpad.c              |  213 +++++++++++++++++++++++----
 b/drivers/pcmcia/sa1100_simpad.c             |   35 ++--
 7 files changed, 275 insertions(+), 171 deletions(-)
