From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 23:19:32 +0800
Subject: [GIT PULL 1/4] ARM: imx: noncritical fixes for 3.10
Message-ID: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-noncritical-fixes-3.10

for you to fetch changes up to 4f5ef62ced8e7e01179de734856e03bddb06389c:

  ARM: cpuimx27 and mbimx27: prepend CONFIG_ to Kconfig macro (2013-04-03 16:50:54 +0800)

----------------------------------------------------------------
The imx noncritical fixes for 3.10:

* A bunch of fixes for sparse warings
* One fix for the typo in use of Kconfig symbol
  MACH_EUKREA_CPUIMX27_USEUART4

----------------------------------------------------------------
Fabio Estevam (15):
      ARM: mach-imx: cpu: Include "common.h"
      ARM: mach-imx: mm-imx3: Staticize imx3_init_l2x0()
      ARM: mach-imx: iomux-imx31: Staticize mxc_pin_alloc_map
      ARM: mach-imx: cpu-imx5: Include "common.h"
      ARM: mach-imx: clk-pllv1: Staticize clk_pllv1_ops
      ARM: mach-imx: clk-pllv2: Staticize clk_pllv2_ops
      ARM: mach-imx: clk-gate2: Include "clk.h"
      ARM: mach-imx: irq-common: Remove imx_irq_set_priority()
      ARM: mach-imx: clk-busy: Staticize clk_busy_mux_ops
      ARM: mach-imx: clk: Include "clk.h"
      ARM: mach-imx: tzic: Staticize *tzic_base
      ARM: mach-imx: avic: Staticize *avic_base
      ARM: mach-imx: gpc: Include "common.h"
      ARM: mach-imx: src: Include "common.h
      ARM: mach-imx: mach-imx6q: Fix sparse warnings

Paul Bolle (1):
      ARM: cpuimx27 and mbimx27: prepend CONFIG_ to Kconfig macro

 arch/arm/mach-imx/avic.c                     |    2 +-
 arch/arm/mach-imx/clk-busy.c                 |    2 +-
 arch/arm/mach-imx/clk-gate2.c                |    1 +
 arch/arm/mach-imx/clk-pllv1.c                |    2 +-
 arch/arm/mach-imx/clk-pllv2.c                |    2 +-
 arch/arm/mach-imx/clk.c                      |    1 +
 arch/arm/mach-imx/cpu-imx5.c                 |    1 +
 arch/arm/mach-imx/cpu.c                      |    1 +
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    4 ++--
 arch/arm/mach-imx/gpc.c                      |    1 +
 arch/arm/mach-imx/iomux-imx31.c              |    2 +-
 arch/arm/mach-imx/irq-common.c               |   19 -------------------
 arch/arm/mach-imx/mach-cpuimx27.c            |    4 ++--
 arch/arm/mach-imx/mach-imx6q.c               |    4 ++--
 arch/arm/mach-imx/mm-imx3.c                  |    2 +-
 arch/arm/mach-imx/src.c                      |    1 +
 arch/arm/mach-imx/tzic.c                     |    2 +-
 17 files changed, 19 insertions(+), 32 deletions(-)
