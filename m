From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 12 Feb 2013 12:18:17 -0300
Subject: [PATCH v2 0/8] ARM: omap2: GPMC cleanup
Message-ID: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is v2 of the small cleanup consisting in:
 * mark some functions as 'static' when appropriate
 * remove an unused function from gpmc.c
 * improve error messages when a CS request fails
 * migrate to dev_err and dev_warn

Changelog from v1:
 * fix gpmc_cs_reserved to return a boolean instead
   of an integer error code
 * add a new patch to the patchset cleaning redundant checks

It has been tested on a IGEP v2 board with OneNAND,
which means the gpmc-nand patch is tested by compilation only.

Altough these patchset is almost trivial,
any feedback or testing is more than welcome.

Ezequiel Garcia (8):
  ARM: omap2: gpmc: Mark local scoped functions static
  ARM: omap2: gpmc: Remove unused gpmc_round_ns_to_ticks() function
  ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
  ARM: omap2: gpmc-nand: Print something useful on CS request failure
  ARM: omap2: gpmc-onenand: Print something useful on CS request failure
  ARM: omap2: gpmc-onenand: Replace pr_err() with dev_err()
  ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with dev_warn()
  ARM: omap2: gpmc: Remove redundant chip select out of range check

 arch/arm/mach-omap2/gpmc-nand.c    |    3 ++-
 arch/arm/mach-omap2/gpmc-onenand.c |    8 +++++---
 arch/arm/mach-omap2/gpmc.c         |   27 ++++++---------------------
 arch/arm/mach-omap2/gpmc.h         |    7 -------
 4 files changed, 13 insertions(+), 32 deletions(-)

-- 
1.7.8.6
