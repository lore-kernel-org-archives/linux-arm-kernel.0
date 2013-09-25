From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Sep 2013 16:30:18 +0800
Subject: [PATCH 0/5] ARM: imx6: export soc info via soc device
Message-ID: <1380097823-29027-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds a few helper functions to initialize soc type and
revision from anatop, and then export imx6 soc info via soc device
sysfs interface based on that.

Shawn Guo (5):
  ARM: imx: add soc revision helper functions
  ARM: imx6q: use common soc revision helpers
  ARM: imx: add a common function to initialize revision from anatop
  ARM: imx: use imx_init_revision_from_anatop() on imx6sl
  ARM: imx6: report soc info via soc device

 arch/arm/boot/dts/imx6sl.dtsi   |    4 +-
 arch/arm/mach-imx/Kconfig       |    1 +
 arch/arm/mach-imx/anatop.c      |   33 +++++++++++---
 arch/arm/mach-imx/clk-imx6q.c   |    5 ++-
 arch/arm/mach-imx/common.h      |    6 ++-
 arch/arm/mach-imx/cpu.c         |   93 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6q.c  |   42 +++++-------------
 arch/arm/mach-imx/mach-imx6sl.c |    9 +++-
 arch/arm/mach-imx/mxc.h         |    1 +
 9 files changed, 149 insertions(+), 45 deletions(-)

-- 
1.7.9.5
