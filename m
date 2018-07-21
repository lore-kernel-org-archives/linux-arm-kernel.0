From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 21 Jul 2018 10:32:20 +0800
Subject: [GIT PULL 2/6] i.MX SoC changes for 4.19
In-Reply-To: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1532140344-2771-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.19

for you to fetch changes up to 26b754f99402d6e7fc4e07d67a2597e6ebabde8b:

  ARM: mx5: Set the DBGEN bit in ARM_GPC register (2018-07-12 09:52:20 +0800)

----------------------------------------------------------------
i.MX SoC update for 4.19:
 - A series from Anson Huang to add power management for i.MX6SLL,
   including standby and mem mode suspend, cpuidle support, and bus
   clock auto gating function, etc.
 - A couple of fix-ups on i.MX6SLL cpuidle random build issues.
 - A couple of cleanups on stale EPIT timer initialization and RNGA
   platform device registration function.
 - Configure i.MX51 SoC M4IF to avoid visual artifacts during video
   playback.
 - Set up i.MX51 and i.MX53 DBGEN bit of ARM_GPC register, so that
   clocks within the debug system can be activated.
 - Add a Cortex-M4 platform support which will be useful for running
   a Linux instance on Cortex-M4 core integrated in i.MX7D SoC.
 - Flag of_iomap failure in imx_aips_allow_unprivileged_access()
   function by giving a warning in there.

----------------------------------------------------------------
Anson Huang (6):
      ARM: imx: add standby mode suspend for i.MX6SLL
      ARM: imx: add mem mode suspend for i.MX6SLL
      ARM: imx: add L2 page power control for GPC
      ARM: imx: add cpu idle support for i.MX6SLL
      ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle driver
      ARM: imx: enable bus auto clock gating function for i.mx6sll

Arnd Bergmann (2):
      ARM: imx: fix i.MX6SLL build
      ARM: imx: call imx6sx_cpuidle_init() conditionally for 6sll

Cl?ment Peron (1):
      ARM: imx: remove inexistant EPIT timer init

Fabio Estevam (2):
      ARM: imx51: Configure M4IF to avoid visual artifacts
      ARM: mx5: Set the DBGEN bit in ARM_GPC register

Nicholas Mc Guire (1):
      ARM: imx: flag failure of of_iomap

Oleksij Rempel (1):
      ARM: imx: Provide support for NXP i.MX7D Cortex-M4

Vladimir Zapolskiy (1):
      ARM: i.MX31: remove rnga registration as a platform device

 arch/arm/mach-imx/Kconfig                   | 33 +++++++++++++--------
 arch/arm/mach-imx/Makefile                  |  5 ++--
 arch/arm/mach-imx/common.h                  |  3 +-
 arch/arm/mach-imx/cpu-imx5.c                | 45 +++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpu.c                     |  1 +
 arch/arm/mach-imx/cpuidle-imx6sl.c          |  7 ++---
 arch/arm/mach-imx/cpuidle-imx6sx.c          |  1 +
 arch/arm/mach-imx/gpc.c                     | 14 +++++++++
 arch/arm/mach-imx/imx31-dt.c                | 18 ------------
 arch/arm/mach-imx/mach-imx51.c              | 30 ++++++++++++++++++-
 arch/arm/mach-imx/mach-imx53.c              |  2 +-
 arch/arm/mach-imx/mach-imx6sl.c             |  5 +++-
 arch/arm/mach-imx/mach-imx7d-cm4.c          | 18 ++++++++++++
 arch/arm/mach-imx/pm-imx6.c                 | 33 +++++++++++++++++++--
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  3 ++
 15 files changed, 174 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c
