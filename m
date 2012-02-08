From: stigge@antcom.de (Roland Stigge)
Date: Wed,  8 Feb 2012 21:40:58 +0100
Subject: [PATCH v4 0/7] ARM: Fixes to make LPC32xx compile and boot again
Message-ID: <1328733665-17836-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the bundle of basic patches to make LPC32xx compile and boot again,
fixing several basic issues. Tested by Wolfram Sang and Acked by Kevin Wells of
NXP, the original author and maintainer of LPC32xx.

Arnd and Olof, please tell if there is still something missing.

Thanks in advance,

Roland


Roland Stigge (7):
  ARM: LPC32xx: Added lpc32xx_defconfig
  ARM: LPC32XX: Remove broken non-static declaration
  ARM: LPC32xx: clock.c: Missing header file
  ARM: LPC32xx: clock.c: jiffies wrapping
  ARM: LPC32xx: clock.c: Clock registration fixes
  ARM: LPC32xx: clock.c: warning fix
  ARM: LPC32xx: clock.c: Fix mutex lock issues

 arch/arm/mach-lpc32xx/clock.c        |   61 ++++----------
 arch/arm/configs/lpc32xx_defconfig   |  145 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/clock.c        |    1 
 arch/arm/mach-lpc32xx/common.h       |    1 
 4 files changed, 166 insertions(+), 42 deletions(-)
