From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 16:51:30 +0900
Subject: [GIT PULL v2 00/27] Renesas ARM-based SoC updates for v3.11
Message-ID: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.11

for you to fetch changes up to 413bfd0e67894c930242482cd15ac09a800e2ab8:

  ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate (2013-06-07 14:24:52 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC updates for v3.11

* Increased clock coverage for r8a7740, r8a73a4, r8a7778 and r8a7790
* Use fixed clock ratio for r8a7778
* Always use shmobile_setup_delay for sh73a0
* Add add CPUFreq support for sh73a0
* Check kick bit before changing rate on sh73a0
* Do not overwrite all div4 clock operations on sh73a0

* Cleanup SH_FIXED_RATIO_CLK and SH_FIXED_RATIO_CLK macros
* sh73a0: Use DEFINE_RES_MEM*() everywhere
* r8a7740: Make private clock arrays static
* r8a7778: Correct model number

The last four changes listed above are cleanups. I have included them
in this series as all bar the last one are dependencies of non-cleanup
patches.

----------------------------------------------------------------
Bastian Hecht (2):
      ARM: shmobile: r8a7740: Add interim sh-eth device name to clocks list
      ARM: shmobile: r8a7740: Add I2C DT clock names

Guennadi Liakhovetski (4):
      ARM: shmobile: sh73a0: add support for adjusting CPU frequency
      ARM: shmobile: sh73a0: add CPUFreq support
      ARM: shmobile: sh73a0: do not overwrite all div4 clock operations
      ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate

Kuninori Morimoto (13):
      ARM: shmobile: remove ";" from SH_FIXED_RATIO_CLK*() macro
      ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
      ARM: shmobile: r8a7778: fixup Ether setup code position
      ARM: shmobile: r8a73a4: add main clock
      ARM: shmobile: r8a73a4: add pll clocks
      ARM: shmobile: r8a73a4: add div4 clocks
      ARM: shmobile: r8a73a4: add div6 clocks
      ARM: shmobile: r8a7778: use fixed ratio clock
      ARM: shmobile: r8a7778: add SDHI clock support
      ARM: shmobile: r8a7778: Register SDHI device
      ARM: shmobile: r8a7790: add main clock
      ARM: shmobile: r8a7790: add div4 clocks
      ARM: shmobile: r8a7790: add div6 clocks

Laurent Pinchart (4):
      ARM: shmobile: r8a7740: Make private clock arrays static
      ARM: shmobile: r8a7740: add TPU PWM support
      ARM: shmobile: r8a7790: Make private clock arrays static
      ARM: shmobile: r8a7790: add TPU PWM support

Magnus Damm (1):
      ARM: shmobile: sh73a0: Always use shmobile_setup_delay()

Phil Edworthy (1):
      ARM: shmobile: r8a7779: Add PCIe clocks

Sergei Shtylyov (1):
      ARM: shmobile: r8a7778: correct model name in Kconfig

Simon Horman (1):
      ARM: shmobile: sh73a0: Use DEFINE_RES_MEM*() everywhere

 arch/arm/mach-shmobile/Kconfig                |   4 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c        | 375 ++++++++++++++++++++++++--
 arch/arm/mach-shmobile/clock-r8a7740.c        |  11 +-
 arch/arm/mach-shmobile/clock-r8a7778.c        | 156 ++++++++++-
 arch/arm/mach-shmobile/clock-r8a7779.c        |   4 +-
 arch/arm/mach-shmobile/clock-r8a7790.c        | 238 +++++++++++++++-
 arch/arm/mach-shmobile/clock-sh73a0.c         | 111 +++++++-
 arch/arm/mach-shmobile/include/mach/clock.h   |   8 +-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |   2 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |  52 +++-
 arch/arm/mach-shmobile/setup-sh73a0.c         |  95 ++-----
 11 files changed, 924 insertions(+), 132 deletions(-)

-- 
1.8.2.1
