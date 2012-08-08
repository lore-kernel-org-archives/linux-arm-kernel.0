From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:48 +0200
Subject: [PATCH 00/10] ARM: interesting warnings from defconfig builds
Message-ID: <1344461278-28245-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of these have been around for quite a while, but I think we
should fix them nonetheless. In some cases, I'm not very sure about
my solution, so I'd appreciate any ACK or NAK I can get.

	Arnd

Arnd Bergmann (10):
  ARM: footbridge: nw_gpio_lock is raw_spin_lock
  ARM: ks8695: __arch_virt_to_dma type handling
  ARM: mv78xx0: fix win_cfg_base prototype
  ARM: pass -marm to gcc by default
  asm-generic: xor: mark static functions as __maybe_unused
  ARM: davinci: don't use broken ntosd2_init_i2c
  ARM: rpc: check device_register return code in ecard_probe
  ARM: s3c24xx: enable CONFIG_BUG for tct_hammer
  ARM: rpc: Fix building RiscPC
  leds: renesas: fix error handling

 arch/arm/Kconfig                           |    2 +-
 arch/arm/Makefile                          |    4 +++-
 arch/arm/configs/tct_hammer_defconfig      |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c  |    7 +++++++
 arch/arm/mach-ks8695/include/mach/memory.h |    3 ++-
 arch/arm/mach-mv78xx0/addr-map.c           |    2 +-
 arch/arm/mach-rpc/ecard.c                  |    4 +++-
 arch/arm/mm/Kconfig                        |   12 ++----------
 drivers/char/ds1620.c                      |    8 ++++----
 drivers/char/nwflash.c                     |    4 ++--
 drivers/leds/leds-renesas-tpu.c            |    2 +-
 include/asm-generic/xor.h                  |    4 ++--
 sound/oss/waveartist.c                     |    4 ++--
 13 files changed, 31 insertions(+), 27 deletions(-)

-- 
1.7.10

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Walle <michael@walle.cc>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Neil Brown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Andrey Porodko <panda@chelcom.ru>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Bryan Wu <bryan.wu@canonical.com>
Cc: Magnus Damm <damm@opensource.se>
