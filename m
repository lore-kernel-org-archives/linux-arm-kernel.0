From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Jan 2015 17:14:26 +0800
Subject: [GIT PULL 1/3] ARM: imx: soc changes for 3.20
Message-ID: <20150123091425.GB27337@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.20

for you to fetch changes up to ade9233f2e0cf4b7bf10fd122c7e9f9310bfd1a5:

  ARM: clk-imx6q: refine esai_ipg's parent (2015-01-20 15:53:41 +0800)

----------------------------------------------------------------
The i.MX SoC changes for 3.20:
 - Add .disable_unused function hook for shared gate clock to ensure
   the clock tree use count matches the hardware state
 - Add a deeper idle state for i.MX6SX cpuidle driver powering off the
   ARM core
 - One correction on i.MX6Q esai_ipg parent clock setting
 - Add a missing iounmap call for imx6q_opp_check_speed_grading()
 - Add missing clocks for VF610 UART4, UART5 and SNVS blocks
 - Expand VF610 device tree compatible matching table to cover more
   Vybrid family SoCs
 - Expand i.MX clk-pllv3 a bit with the shift for frequency multiplier
   to support Vybrid's USB PLL oddity

----------------------------------------------------------------
Anson Huang (3):
      ARM: imx: correct the hardware clock gate setting for shared nodes
      ARM: imx: remove unnecessary setting for DSM
      ARM: imx: support arm power off in cpuidle for i.mx6sx

Bhuvanchandra DV (1):
      ARM: imx: clk-vf610: Add clock for UART4 and UART5

Sanchayan Maity (1):
      ARM: imx: clk-vf610: Add clock for SNVS

Sebastian Andrzej Siewior (1):
      ARM i.MX6q: unmap memory mapped at imx6q_opp_check_speed_grading()

Shawn Guo (1):
      ARM: imx: drop CPUIDLE_FLAG_TIME_VALID from cpuidle-imx6sx

Shengjiu Wang (1):
      ARM: clk-imx6q: refine esai_ipg's parent

Stefan Agner (2):
      ARM vf610: add compatibilty strings of supported Vybrid SoC's
      ARM: imx: pllv3: add shift for frequency multiplier

 Documentation/devicetree/bindings/arm/fsl.txt |  12 +++
 arch/arm/mach-imx/Makefile                    |   3 +-
 arch/arm/mach-imx/clk-gate2.c                 |  23 +++++-
 arch/arm/mach-imx/clk-imx6q.c                 |   2 +-
 arch/arm/mach-imx/clk-pllv3.c                 |  10 ++-
 arch/arm/mach-imx/clk-vf610.c                 |   8 +-
 arch/arm/mach-imx/clk.h                       |   1 +
 arch/arm/mach-imx/common.h                    |   4 +
 arch/arm/mach-imx/cpuidle-imx6sx.c            | 105 ++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h                   |   5 ++
 arch/arm/mach-imx/gpc.c                       |  25 +++++-
 arch/arm/mach-imx/mach-imx6q.c                |   2 +-
 arch/arm/mach-imx/mach-imx6sx.c               |   2 +-
 arch/arm/mach-imx/mach-vf610.c                |   5 +-
 arch/arm/mach-imx/pm-imx6.c                   |   7 +-
 include/dt-bindings/clock/vf610-clock.h       |   3 +-
 16 files changed, 195 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6sx.c
