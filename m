From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 14:21:01 -0700
Subject: [PATCH 0/2] omap gpmc changes for parsing devices and working debug
Message-ID: <1432156863-19695-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few fixes that allow to hook any devices to GPMC
instead of artificially limiting them by name. There are at
least FPGAs and USB controllers that I'm aware of.

Then we need disable hwmod reset for GPMC debug, otherwise
debug only shows the default memory timings.. Let's do this
with a Kconfig option.

Regards,

Tony


Tony Lindgren (2):
  memory: omap-gpmc: Fix parsing of devices
  memory: omap-gpmc: Add Kconfig option for debug

 arch/arm/mach-omap2/omap_hwmod.h                        |  6 ++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 12 ++----------
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 12 ++----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c              | 11 ++---------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c               |  4 ++--
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c              |  2 ++
 drivers/memory/Kconfig                                  |  8 ++++++++
 drivers/memory/omap-gpmc.c                              | 14 ++++----------
 9 files changed, 30 insertions(+), 42 deletions(-)

-- 
2.1.4
