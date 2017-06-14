From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jun 2017 00:31:11 -0700
Subject: [PATCH 0/7] Clean-up for debug_ll for omap variants
Message-ID: <20170614073118.28246-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Inspired by earlier patches to remove DEBUG_OMAP2PLUS_UART dependency
to DEBUG_UNCOMPRESS by Hoeun Ryu <hoeun.ryu@gmail.com>, I converted
all mach-omap2 to use generic 8250 debug_ll code.

I've tested this on omap2/3/4/5, ti81xx and am437x so far and things
seem to work as expected.

Regards,

Tony

Tony Lindgren (7):
  ARM: debug: Use generic 8250 debug_ll for omap2 and omap3/4/5 common
    uarts
  ARM: debug: Use generic 8250 debug_ll for omap3/4/5
  ARM: debug: Use generic 8250 debug_ll for ti81xx
  ARM: debug: Use generic 8250 debug_ll for am3517 and am335x
  ARM: debug: Use generic 8250 debug_ll for omap zoom
  ARM: debug: Update port descriptions for omap variants
  ARM: OMAP2+: Drop unused serial.h

 arch/arm/Kconfig.debug                             |  60 ++++---
 arch/arm/include/debug/omap2plus.S                 | 190 ---------------------
 arch/arm/mach-omap2/common.h                       |   1 -
 arch/arm/mach-omap2/include/mach/serial.h          |  66 -------
 arch/arm/mach-omap2/io.c                           |   1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   1 -
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   1 -
 arch/arm/mach-omap2/serial.h                       |   1 -
 9 files changed, 40 insertions(+), 282 deletions(-)
 delete mode 100644 arch/arm/include/debug/omap2plus.S
 delete mode 100644 arch/arm/mach-omap2/include/mach/serial.h
 delete mode 100644 arch/arm/mach-omap2/serial.h

-- 
2.13.0
