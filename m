From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 22 Jan 2013 22:14:05 +0530
Subject: [PATCH 0/4] ARM: AM335x: LCDC platform support
Message-ID: <cover.1358871018.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series make am335x lcdc capable of providing display.
Certain changes were required in generic OMAP clock handling
to attain it. Clock nodes in LCDC path is marked such that
rate can get propogated to upstream clocks till display PLL.

Based on 3.8-rc3.

Tested on AM335x EVM.

To test on AM335x based boards, tree
@ git://gitorious.org/x0148406-public/linux-kernel.git tags/da8xx-fb-dt-v3

Regards
Afzal

Afzal Mohammed (4):
  ARM: OMAP2+: dpll: round rate to closest value
  ARM: OMAP2+: dpll: am335x - avoid freqsel
  ARM: OMAP2+: clock: DEFINE_STRUCT_CLK_FLAGS helper
  ARM: AM33XX: clock: SET_RATE_PARENT in lcd path

 arch/arm/mach-omap2/cclock33xx_data.c | 11 ++++++-----
 arch/arm/mach-omap2/clkt_dpll.c       | 12 +++++++-----
 arch/arm/mach-omap2/clock.h           | 11 +++++++++++
 arch/arm/mach-omap2/dpll3xxx.c        |  5 +++--
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
1.7.12
