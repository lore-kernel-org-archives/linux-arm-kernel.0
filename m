From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 Sep 2012 15:12:45 -0600
Subject: [PATCH 0/3] ARM: OMAP2+: hwmod: resolve some OMAP4 warnings
Message-ID: <20120918211146.16484.85893.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decision was made a few months ago to weaken the clockdomain
requirements for hwmods and clocks.  Convert some of these
warnings into debug messages.  In other cases, don't return an
error when a clockdomain isn't specified.  And while here,
appropriately mark some OMAP4 hwmods that don't have idle
reporting bits.

---

hwmod_omap4_warning_fixes_a_3.7
   text    data     bss     dec     hex filename
7333017  764092 5611596 13708705         d12da1 vmlinux.omap2plus_defconfig.orig
7332977  764068 5611596 13708641         d12d61 vmlinux.omap2plus_defconfig

Paul Walmsley (3):
      ARM: OMAP4: hwmod data: add missing HWMOD_NO_IDLEST flags to some PRCM IP blocks
      ARM: OMAP4+: hwmod code: remove clkdm requirement in _omap4_wait_target_*()
      ARM: OMAP2+: hwmod code: convert missing clockdomain warnings to debug messages


 arch/arm/mach-omap2/omap_hwmod.c           |   16 +++++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
 2 files changed, 12 insertions(+), 7 deletions(-)
