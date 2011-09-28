From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Sep 2011 17:16:02 +0800
Subject: [PATCH 0/6] Support single zImage for imx3 and imx6
Message-ID: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series supports the single zImage build for imx3 and imx6.  It's
based on linux-next with imx6 series applied, and tested on imx35 and
imx6q.

Sascha Hauer (1):
      arm/imx: merge i.MX3 and i.MX6

Shawn Guo (5):
      arm/imx: merge mm-imx35.c into mm-imx31.c
      arm/imx: rename mm-imx31.c to mm-imx3.c
      arm/imx: change mxc_init_l2x0() to an imx31/35 specific call
      arm/imx: remove cpu_is_xxx() from arch_idle()
      arm/imx: remove cpu_is_xxx() check from __imx_ioremap()

 arch/arm/Makefile                       |    3 +-
 arch/arm/mach-imx/Kconfig               |    7 +-
 arch/arm/mach-imx/Makefile              |    5 +-
 arch/arm/mach-imx/Makefile.boot         |   10 +-
 arch/arm/mach-imx/cache-l2x0.c          |   56 -------
 arch/arm/mach-imx/mm-imx3.c             |  256 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mm-imx31.c            |   91 -----------
 arch/arm/mach-imx/mm-imx35.c            |  109 -------------
 arch/arm/mach-mx5/mm.c                  |    6 +
 arch/arm/mach-mx5/pm-imx5.c             |    3 +-
 arch/arm/mm/Kconfig                     |    4 +-
 arch/arm/plat-mxc/Kconfig               |   18 +--
 arch/arm/plat-mxc/include/mach/common.h |    2 +
 arch/arm/plat-mxc/include/mach/io.h     |   22 +--
 arch/arm/plat-mxc/include/mach/system.h |   35 +----
 arch/arm/plat-mxc/system.c              |    3 +
 16 files changed, 300 insertions(+), 330 deletions(-)
