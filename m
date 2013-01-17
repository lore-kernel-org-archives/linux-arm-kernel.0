From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 23:21:57 +0800
Subject: [PATCH 0/2] Uncompress debug for multiplatform
Message-ID: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not about running single zImage on multiple platforms with
uncompress debug output, but having uncompress debug work for platform
that DEBUG_LL is enabled for.  But still it's better than nothing.

Shawn Guo (2):
  ARM: use Kconfig to select uncompress.h
  ARM: use DEBUG_LL infrastructural for multiplatform uncompress debug

 arch/arm/Kconfig.debug              |    5 +++++
 arch/arm/boot/compressed/Makefile   |    3 +++
 arch/arm/boot/compressed/debug.S    |    3 +++
 arch/arm/boot/compressed/misc.c     |    8 +-------
 arch/arm/include/debug/highbank.S   |    3 +++
 arch/arm/include/debug/imx.S        |    3 +++
 arch/arm/include/debug/mvebu.S      |    3 +++
 arch/arm/include/debug/picoxcell.S  |    3 +++
 arch/arm/include/debug/socfpga.S    |    3 +++
 arch/arm/include/debug/sunxi.S      |    3 +++
 arch/arm/include/debug/tegra.S      |    3 +++
 arch/arm/include/debug/uncompress.h |    9 +++++++++
 arch/arm/include/debug/vexpress.S   |    3 +++
 arch/arm/include/debug/zynq.S       |    3 +++
 14 files changed, 48 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/compressed/debug.S
 create mode 100644 arch/arm/include/debug/uncompress.h

-- 
1.7.9.5
