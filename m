From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  1 Mar 2016 23:00:00 +0800
Subject: [GIT PULL 1/4] ARM: imx: soc updates for 4.6
Message-ID: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.6

for you to fetch changes up to d2443b2e6167e80eca9a068d5ecc0e6f081b3ca4:

  ARM: imx: Make reset_control_ops const (2016-02-29 10:37:44 +0800)

----------------------------------------------------------------
The i.MX SoC update for 4.6:
- Enable big endian mode support for i.MX platform
- Add support for i.MX6QP SoC which is the latest i.MX6 family addition
- Add basic suspend/resume support for i.MX25
- A couple of i.MX7D support updates
- A few random code cleanups

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: imx: select ARM_CPU_SUSPEND only for imx6

Bai Ping (1):
      ARM: imx: Add msl code support for imx6qp

Dirk Behme (1):
      ARM: imx: Do L2 errata only if the L2 cache isn't enabled

Fabio Estevam (1):
      ARM: mx25: Add basic suspend/resume support

Frank Li (2):
      ARM: imx: select HAVE_ARM_ARCH_TIMER if selected i.MX7D
      ARM: imx7d: correct chip version information

Jean-Christophe Dubois (1):
      ARM: imx6: fix cleanup path in imx6q_suspend_init()

Johannes Berg (2):
      ARM: imx: use endian-safe readl/readw/writel/writew
      ARM: imx: enable big endian mode

Philipp Zabel (1):
      ARM: imx: Make reset_control_ops const

 arch/arm/include/debug/imx.S          |  3 +++
 arch/arm/mach-imx/3ds_debugboard.c    | 30 ++++++++++++++--------------
 arch/arm/mach-imx/Kconfig             |  4 +++-
 arch/arm/mach-imx/Makefile            |  2 +-
 arch/arm/mach-imx/anatop.c            | 18 +++++++++++++++--
 arch/arm/mach-imx/avic.c              | 30 ++++++++++++++--------------
 arch/arm/mach-imx/common.h            |  1 +
 arch/arm/mach-imx/cpu-imx27.c         |  3 +--
 arch/arm/mach-imx/cpu-imx31.c         |  2 +-
 arch/arm/mach-imx/cpu-imx35.c         |  2 +-
 arch/arm/mach-imx/cpu.c               | 16 +++++++--------
 arch/arm/mach-imx/epit.c              | 22 ++++++++++-----------
 arch/arm/mach-imx/headsmp.S           |  2 ++
 arch/arm/mach-imx/iomux-imx31.c       | 12 ++++++------
 arch/arm/mach-imx/iomux-v1.c          |  4 ++--
 arch/arm/mach-imx/iomux-v3.c          |  6 +++---
 arch/arm/mach-imx/mach-armadillo5x0.c |  4 ++--
 arch/arm/mach-imx/mach-imx25.c        |  1 +
 arch/arm/mach-imx/mach-imx51.c        |  5 ++---
 arch/arm/mach-imx/mach-imx6q.c        |  8 ++++++--
 arch/arm/mach-imx/mach-mx27ads.c      |  6 +++---
 arch/arm/mach-imx/mach-mx31ads.c      | 16 +++++++--------
 arch/arm/mach-imx/mach-mx31moboard.c  |  2 +-
 arch/arm/mach-imx/mach-qong.c         |  6 +++---
 arch/arm/mach-imx/mxc.h               |  5 +++++
 arch/arm/mach-imx/pm-imx25.c          | 37 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/pm-imx27.c          |  4 ++--
 arch/arm/mach-imx/pm-imx3.c           |  4 ++--
 arch/arm/mach-imx/pm-imx5.c           | 26 ++++++++++++------------
 arch/arm/mach-imx/pm-imx6.c           |  8 ++++----
 arch/arm/mach-imx/src.c               |  2 +-
 arch/arm/mach-imx/system.c            | 10 +++++++---
 arch/arm/mach-imx/tzic.c              | 34 ++++++++++++++++----------------
 33 files changed, 203 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx25.c
