From: stigge@antcom.de (Roland Stigge)
Date: Thu, 28 Jun 2012 00:26:10 +0200
Subject: [PATCH 0/8] ARM: LPC32xx specific updates for next, second set
Message-ID: <1340835978-20331-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second round of patches for mach-lpc32xx, for v3.6. It builds upon
the first round of 22 patches and includes clock updates that separate out
initialization from the board specific init to clock.c.

Further, a defconfig update for LPC32xx, dts file update and mmc bugfix is
included.

Signed-off-by: Roland Stigge <stigge@antcom.de>

--

You can also pull from

  git://git.antcom.de/linux-2.6.git lpc32xx-next2

Roland Stigge (6):
 ARM: LPC32xx: Init MMC via clock
 ARM: LPC32xx: Add further bits to MMC init
 ARM: LPC32xx: Remove wrong re-initialization of MMC clock register
 ARM: LPC32xx: Update DTS file for EA3250 board
 ARM: LPC32xx: Defconfig update
 ARM: LPC32xx: Remove USB and I2C init from phy3250.c
Alexandre Pereira da Silva (2):
 ARM: LPC32xx: Cleanup USB clock init
 ARM: LPC32xx: Remove unused gpios

 arch/arm/boot/dts/ea3250.dts                  |   17 ++++
 arch/arm/configs/lpc32xx_defconfig            |    2 
 arch/arm/mach-lpc32xx/clock.c                 |   90 ++++++++++++++++++++++----
 arch/arm/mach-lpc32xx/include/mach/platform.h |   14 ++++
 arch/arm/mach-lpc32xx/phy3250.c               |   20 -----
 5 files changed, 112 insertions(+), 31 deletions(-)
