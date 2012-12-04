From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  4 Dec 2012 22:55:11 +0800
Subject: [PATCH v2 0/4] Support imx6q WAIT mode
Message-ID: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With more intensive testing on different revisions of imx6q, we found
that the power gating state can not always work reliably.  So v2 of
the series drops the support for that state and adds clock gating state
only.  As the result, we need not to use coupled cpuidle now.

Shawn Guo (4):
  ARM: imx: allow timer counter to roll over
  ARM: imx: mask gpc interrupts initially
  ARM: imx: move imx6q_cpuidle_driver into a separate file
  ARM: imx6q: support WAIT mode using cpuidle

 arch/arm/mach-imx/Makefile        |    6 ++-
 arch/arm/mach-imx/clk-imx6q.c     |   12 +++++
 arch/arm/mach-imx/common.h        |    3 ++
 arch/arm/mach-imx/cpuidle-imx6q.c |   98 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h       |    5 ++
 arch/arm/mach-imx/gpc.c           |    5 ++
 arch/arm/mach-imx/mach-imx6q.c    |   17 +++----
 arch/arm/mach-imx/platsmp.c       |   10 ++++
 arch/arm/mach-imx/time.c          |    6 +--
 9 files changed, 146 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c

-- 
1.7.9.5
