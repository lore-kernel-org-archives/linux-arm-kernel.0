From: stigge@antcom.de (Roland Stigge)
Date: Sat, 11 Feb 2012 18:18:22 +0100
Subject: [PATCH 0/6] ARM: LPC32xx: Second patch set w/ fixes and completion
 for this arch
Message-ID: <1328980708-11749-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is another bundle of patches for LPC32xx, fixing bugs and completing
support for drivers using the LPC32xx base port.

It synchronizes changes from lpclinux.com to the mainline kernel and applies
cleanly to 3.3-rc3.


Roland Stigge (6):
  ARM: LPC32xx: Fix gpio-lpc32xx.c: Pin masking missing
  ARM: LPC32xx: Add output reading to GPO P3
  ARM: LPC32xx: Fix irq on GPI_28
  ARM: LPC32xx: Fix missing and bad LPC32XX macros
  ARM: LPC32xx: Fix interrupt controller init
  ARM: LPC32xx: irq.c: Clear latched event

 arch/arm/mach-lpc32xx/irq.c                             |   11 ++
 b/arch/arm/mach-lpc32xx/include/mach/irqs.h             |    2 
 b/arch/arm/mach-lpc32xx/irq.c                           |    4 
 b/drivers/gpio/gpio-lpc32xx.c                           |   72 ++++++++--------
 drivers/gpio/gpio-lpc32xx.c                             |   17 +++
 linux-2.6/arch/arm/mach-lpc32xx/include/mach/platform.h |   51 ++++++-----
 linux-2.6/arch/arm/mach-lpc32xx/irq.c                   |   10 +-
 linux-2.6/arch/arm/mach-lpc32xx/pm.c                    |    2 
 linux-2.6/arch/arm/mach-lpc32xx/timer.c                 |   46 +++++-----
 9 files changed, 125 insertions(+), 90 deletions(-)
