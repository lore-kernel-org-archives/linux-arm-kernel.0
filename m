From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 7 Oct 2011 01:53:41 -0600 (MDT)
Subject: [GIT PULL] ARM: OMAP3+: clock fixes for 3.2
Message-ID: <alpine.DEB.2.00.1110070141450.4611@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit be73246058737beec52ae232bcab7776332a9e06:

  ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 omap_clock_fixes_3.2

Jon Hunter (3):
      ARM: OMAP3+: dpll: use DPLLs recalc function instead of omap2_get_dpll_rate
      ARM: OMAP4: clock: Add missing clock divider for OCP_ABE_ICLK
      OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices

Mike Turquette (3):
      ARM: OMAP4: clock: round_rate and recalc functions for DPLL_ABE
      ARM: OMAP3+: dpll: use DPLL's round_rate when setting rate
      ARM: OMAP3+: dpll: assign clk rate from rounded rate during rate set

Paul Walmsley (1):
      ARM: OMAP4460: Clock: Adding support for 4460 specific clocks

 arch/arm/mach-omap2/clkt_dpll.c      |   51 +++++++++++++++++--------
 arch/arm/mach-omap2/clock.h          |    2 +
 arch/arm/mach-omap2/clock44xx.h      |    7 +++
 arch/arm/mach-omap2/clock44xx_data.c |   32 +++++++++++----
 arch/arm/mach-omap2/dpll3xxx.c       |    9 +++-
 arch/arm/mach-omap2/dpll44xx.c       |   69 ++++++++++++++++++++++++++++++++++
 6 files changed, 142 insertions(+), 28 deletions(-)


- Paul
