From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 13:46:37 +0800
Subject: [GIT PULL] imx6q cpuidle for 3.9
Message-ID: <20130129054635.GA21504@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx6q-cpudile-3.9

for you to fetch changes up to e510aafde64a3fdd741f598e4d2be3c079bf5b0e:

  ARM: imx6q: support WAIT mode using cpuidle (2013-01-29 13:41:42 +0800)

----------------------------------------------------------------
It's imx6q cpuidle series for 3.9.

----------------------------------------------------------------
Shawn Guo (4):
      ARM: imx: return zero in case next event gets a large increment
      ARM: imx: mask gpc interrupts initially
      ARM: imx: move imx6q_cpuidle_driver into a separate file
      ARM: imx6q: support WAIT mode using cpuidle

 arch/arm/mach-imx/Makefile        |    6 ++-
 arch/arm/mach-imx/clk-imx6q.c     |   12 +++++
 arch/arm/mach-imx/common.h        |    3 ++
 arch/arm/mach-imx/cpuidle-imx6q.c |   95 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h       |    5 ++
 arch/arm/mach-imx/gpc.c           |    5 ++
 arch/arm/mach-imx/mach-imx6q.c    |   17 +++----
 arch/arm/mach-imx/platsmp.c       |   10 ++++
 arch/arm/mach-imx/time.c          |    3 +-
 9 files changed, 143 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
