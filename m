From: mporter@linaro.org (Matt Porter)
Date: Fri, 23 May 2014 09:01:05 -0400
Subject: [GIT PULL] ARM: mach-bcm: cleanups for 3.16
Message-ID: <20140523130105.GA23742@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider pulling the following cleanups for 3.16.

-Matt

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/for-3.16/bcm-cleanup

for you to fetch changes up to eeda4cb92ee0fb63a5917738e107b0bc8168079e:

  ARM: bcm: rename "kona.h" and "kona.c" (2014-04-25 08:51:38 -0400)

----------------------------------------------------------------
mach-bcm mobile SoC cleanups

* Clean up mach-bcm config and build targets
* Clean up bcm281xx/21664 SMC code
* Clean up bcm281xx/21664 L2C code

----------------------------------------------------------------
Alex Elder (11):
      ARM: bcm: clean up config and build targets
      ARM: bcm: use memory accessors for ioremapped area
      ARM: bcm: err, don't BUG() on SMC init failures
      ARM: bcm: clean up SMC code
      ARM: bcm: have bcm_kona_smc() return request result
      ARM: bcm: don't special-case CPU 0 in bcm_kona_smc()
      ARM: bcm: config option for l2 cache support
      ARM: bcm: tidy up a few includes
      ARM: bcm: use inline assembly for "smc" request
      ARM: bcm: rewrite commentary for bcm_kona_do_smc()
      ARM: bcm: rename "kona.h" and "kona.c"

 arch/arm/mach-bcm/Kconfig                     |  40 +++++++-
 arch/arm/mach-bcm/Makefile                    |  21 +++-
 arch/arm/mach-bcm/bcm_kona_smc.c              | 136 +++++++++++++++++++-------
 arch/arm/mach-bcm/bcm_kona_smc.h              |  52 +---------
 arch/arm/mach-bcm/bcm_kona_smc_asm.S          |  41 --------
 arch/arm/mach-bcm/board_bcm21664.c            |   5 +-
 arch/arm/mach-bcm/board_bcm281xx.c            |   2 +-
 arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} |  16 +--
 arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} |   6 +-
 9 files changed, 170 insertions(+), 149 deletions(-)
 delete mode 100644 arch/arm/mach-bcm/bcm_kona_smc_asm.S
 rename arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} (80%)
 rename arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} (80%)
