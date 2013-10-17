From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Oct 2013 11:17:10 +0800
Subject: [PATCH 0/4] ARM: imx: suspend support for imx6dl and imx6sl
Message-ID: <1381979834-20998-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series enables suspend support for imx6dl and imx6sl with reusing
imx6q suspend code.

The patch #3 works around a defect with low power mode design which
affects all three existing imx6 SoCs, although the issue is hard to
be seen on imx6q due to its AXI fabric FIFO.  FSL will publish an errata
for it soon.

Shawn Guo (4):
  ARM: imx6q: move low-power code out of clock driver
  ARM: imx6q: call WB and RBC configuration from imx6q_pm_enter()
  ARM: imx: ensure dsm_request signal is not asserted when setting LPM
  ARM: imx: enable suspend for imx6sl

 arch/arm/boot/dts/imx6sl.dtsi   |    3 +-
 arch/arm/mach-imx/Makefile      |    2 +
 arch/arm/mach-imx/clk-imx6q.c   |  156 +---------------------------------
 arch/arm/mach-imx/clk-imx6sl.c  |    3 +
 arch/arm/mach-imx/common.h      |    5 ++
 arch/arm/mach-imx/gpc.c         |    4 +-
 arch/arm/mach-imx/mach-imx6sl.c |    3 +
 arch/arm/mach-imx/mxc.h         |    5 ++
 arch/arm/mach-imx/pm-imx6q.c    |  176 ++++++++++++++++++++++++++++++++++++++-
 9 files changed, 199 insertions(+), 158 deletions(-)

-- 
1.7.9.5
