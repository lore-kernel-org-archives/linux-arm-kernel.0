From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:14 -0700
Subject: [PATCH 0/8] OMAP clock & IO mapping fixes for 2.6.33-rc2
Message-ID: <20091218041912.27280.92152.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are some relatively minor OMAP fixes for 2.6.33-rc2.  The most
significant one is:

    OMAP2420 IO mapping: move IVA mapping virtual address out of vmalloc space

Without it, OMAP2420 systems with lots of vmalloc() usage could crash or
memory could be corrupted.


- Paul

---

Abhijit Pagare (1):
      ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.

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


 arch/arm/mach-omap2/clock34xx.c      |    1 -
 arch/arm/mach-omap2/clock34xx_data.c |    6 +++++-
 arch/arm/mach-omap2/clockdomain.c    |    4 ++--
 arch/arm/mach-omap2/io.c             |   19 +++++++++---------
 arch/arm/plat-omap/clock.c           |    6 ------
 arch/arm/plat-omap/include/plat/io.h |   36 +++++++++++++++-------------------
 arch/arm/plat-omap/io.c              |   12 ++++++-----
 7 files changed, 38 insertions(+), 46 deletions(-)


   text	   data	    bss	    dec	    hex	filename
3628182	 197984	 102920	3929086	 3bf3fe	vmlinux.beagle.orig
3628135	 197984	 102920	3929039	 3bf3cf	vmlinux.beagle
