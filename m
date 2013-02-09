From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat,  9 Feb 2013 13:38:09 -0300
Subject: [PATCH 0/7] ARM: omap2: GPMC cleanup
Message-ID: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a small cleanup consisting in:
 * mark some functions as 'static' when appropriate
 * remove an unused function from gpmc.c
 * improve error messages when a CS request fails
 * migrate to dev_err and dev_warn

It has been tested on a IGEP v2 board with OneNAND,
which means the gpmc-nand patch is tested by compilation only.

Altough these patchset is almost trivial,
any feedback or testing is more than welcome.

Ezequiel Garcia (7):
  ARM: omap2: gpmc: Mark local scoped functions static
  ARM: omap2: gpmc: Remove unused gpmc_round_ns_to_ticks() function
  ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
  ARM: omap2: gpmc-nand: Print something useful on CS request failure
  ARM: omap2: gpmc-onenand: Print something useful on CS request failure
  ARM: omap2: gpmc-onenand: Replace pr_err() with dev_err()
  ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with dev_warn()

 arch/arm/mach-omap2/gpmc-nand.c    |    3 ++-
 arch/arm/mach-omap2/gpmc-onenand.c |    8 +++++---
 arch/arm/mach-omap2/gpmc.c         |   31 ++++++++++++++-----------------
 arch/arm/mach-omap2/gpmc.h         |    7 -------
 4 files changed, 21 insertions(+), 28 deletions(-)

-- 
1.7.8.6
