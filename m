From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 22 Dec 2009 09:07:51 -0700 (MST)
Subject: [GIT PULL] OMAP clock/vmalloc fixes for 2.6.33-rc
Message-ID: <alpine.DEB.2.00.0912220906130.5563@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tony,

The following changes since commit 55639353a0035052d9ea6cfe4dde0ac7fcbb2c9f:
  Linus Torvalds (1):
        Linux 2.6.33-rc1

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 for_2_6_33_rc_a

Abhijit Pagare (1):
      ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.

Cory Maccarrone (1):
      OMAP1 clock: Add missing clocks for OMAP 7xx

Huang Weiyi (1):
      OMAP2: remove duplicated #include

Kevin Hilman (1):
      OMAP3: clock: add clockdomains for UART1 & 2

Paul Walmsley (4):
      OMAP2xxx IO mapping: mark DSP mappings as being 2420-only
      OMAP2420 IO mapping: move IVA mapping virtual address out of vmalloc space
      OMAP3 clock: McBSP 2, 3, 4 functional clock parent is PER_96M_FCLK, not CORE_96M_FCLK
      OMAP clock: remove incorrect EXPORT_SYMBOL()s

Tuukka Toivonen (1):
      OMAP3 clock: Add capability to change rate of dpll4_m5_ck

 arch/arm/mach-omap1/clock_data.c     |    4 +-
 arch/arm/mach-omap2/clock34xx.c      |    1 -
 arch/arm/mach-omap2/clock34xx_data.c |    6 ++++-
 arch/arm/mach-omap2/clockdomain.c    |    4 +-
 arch/arm/mach-omap2/io.c             |   19 ++++++++---------
 arch/arm/plat-omap/clock.c           |    6 -----
 arch/arm/plat-omap/include/plat/io.h |   36 +++++++++++++++------------------
 arch/arm/plat-omap/io.c              |   12 +++++-----
 8 files changed, 40 insertions(+), 48 deletions(-)


- Paul
