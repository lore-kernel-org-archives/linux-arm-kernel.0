From: jhovold@gmail.com (Johan Hovold)
Date: Tue,  5 Feb 2013 14:35:10 +0100
Subject: [PATCH 0/5] atmel_lcdfb: regression fixes and cpu_is removal
In-Reply-To: <20130129135435.GN7360@game.jcrosoft.org>
References: <20130129135435.GN7360@game.jcrosoft.org>
Message-ID: <1360071315-4032-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first three patches are resends of two regression fixes and one clean up
posted in December (with previous acked-bys included). The regression fixes are
kept minimal and are tagged for stable.

The last two patches replace all uses of cpu_is macros in atmel_lcdfb with a
platform-device-id table and static configurations.

Thanks,
Johan


Johan Hovold (5):
  atmel_lcdfb: fix 16-bpp modes on older SOCs
  ARM: at91/neocore926: fix LCD-wiring mode
  atmel_lcdfb: remove unsupported 15-bpp mode
  atmel_lcdfb: move lcdcon2 register access to compute_hozval
  ARM: at91/avr32/atmel_lcdfb: replace cpu_is macros with device-id
    table

 arch/arm/mach-at91/at91sam9261_devices.c |   6 +-
 arch/arm/mach-at91/at91sam9263_devices.c |   2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |   6 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |   2 +-
 arch/arm/mach-at91/board-neocore926.c    |   2 +-
 arch/avr32/mach-at32ap/at32ap700x.c      |   2 +
 drivers/video/atmel_lcdfb.c              | 115 ++++++++++++++++++++++++++-----
 include/video/atmel_lcdc.h               |   4 +-
 8 files changed, 116 insertions(+), 23 deletions(-)

-- 
1.8.1.1
