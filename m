From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Apr 2012 16:37:08 -0700
Subject: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
Message-ID: <1335829030-19431-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The detection of AM35xx SoCs is confusing and has redundancies.  Clean
this up so that SoC detection is only based on SoC family: AM35xx.

Kevin Hilman (2):
  ARM: OMAP: AM35xx: remove redunant cpu_is checks for AM3505
  ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx

 arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
 arch/arm/mach-omap2/id.c                      |    7 +++----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h         |    8 ++++++++
 7 files changed, 19 insertions(+), 12 deletions(-)

-- 
1.7.9.2
