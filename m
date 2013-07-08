From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Jul 2013 22:23:00 +0800
Subject: [PATCH 0/2] Optimize L2 setting on imx6sl
Message-ID: <1373293383-15128-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series leverages the L2 optimization done on imx6q/dl for imx6sl,
by moving imx6q_init_l2cache() out from mach-imx6q.c into system.c and
renaming it imx_init_l2cache().

Shawn Guo (2):
  ARM: imx: let L2 initialization be a common function
  ARM: imx: use imx specific L2 init function on imx6sl

 arch/arm/mach-imx/common.h      |    6 ++++++
 arch/arm/mach-imx/mach-imx6q.c  |   37 +------------------------------------
 arch/arm/mach-imx/mach-imx6sl.c |    3 +--
 arch/arm/mach-imx/system.c      |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 38 deletions(-)

-- 
1.7.9.5
