From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 3 Dec 2012 14:41:11 -0600
Subject: [PATCH V2 0/4] ARM: OMAP4: Clock fixes
Message-ID: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes included, fixing up timer clock aliases for v3.8 and working
around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).

Testing includes:
- Boot testing on OMAP4460 Panda and verifying that all dmtimers are
  working.

V2 changes:
- Updated series to latest ARM-SoC for-next branch that includes common
  clock updates for OMAP4.
- Added new function table for non-M4X DPLLs which is now required after
  enhancing support for OMAP4 DPLLs for 4X multiplier.

Jon Hunter (4):
  ARM: OMAP4: Update timer clock aliases
  ARM: OMAP4: Add function table for non-M4X dplls
  ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
  ARM: OMAP4460: Workaround ABE DPLL failing to turn-on

 arch/arm/mach-omap2/cclock44xx_data.c |   49 ++++++++++++++++++++-----
 arch/arm/mach-omap2/clock.h           |   10 ++++++
 arch/arm/mach-omap2/dpll3xxx.c        |   46 ++++++++++++++++--------
 arch/arm/mach-omap2/dpll44xx.c        |   64 ++++++++++++++++++++++++++++-----
 4 files changed, 138 insertions(+), 31 deletions(-)

-- 
1.7.9.5
