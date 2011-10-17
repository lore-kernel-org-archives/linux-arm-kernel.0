From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Oct 2011 14:15:05 +0800
Subject: [PATCH 0/5] Fix indirect inclusion to <mach/hardware.h>
Message-ID: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With rmk's mach/gpio.h cleanup series merged into arm-soc/imx tree,
plat-mxc/include/mach/gpio.h will become an empty file waiting for 
a global removal of mach/gpio.h.

Currently, this mach/gpio.h includes mach/hardware.h.  Once mach/gpio.h
becomes an empty file, we will hit a number of imx build errors caused
by the indirect inclusion to mach/hardware.h.  This series is trying to
address these errors before above two trees gets merged, which will
happen pretty soon, I believe.

Shawn Guo (5):
      arm/imx: remove mx31_setup_weimcs() from mx31.h
      arm/imx: explicitly includes mach/hardware.h in mach-kzm_arm11_01.c
      arm/imx: remove mx27_setup_weimcs() from mx27.h
      arm/imx: explicitly includes mach/hardware.h in pm-imx27.c
      mmc: mxcmmc: explicitly includes mach/hardware.h

 arch/arm/mach-imx/mach-kzm_arm11_01.c |    1 +
 arch/arm/mach-imx/mach-pcm038.c       |    4 +++-
 arch/arm/mach-imx/mach-qong.c         |    5 ++++-
 arch/arm/mach-imx/pm-imx27.c          |    2 +-
 arch/arm/plat-mxc/include/mach/mx27.h |   14 --------------
 arch/arm/plat-mxc/include/mach/mx31.h |   14 --------------
 drivers/mmc/host/mxcmmc.c             |    1 +
 7 files changed, 10 insertions(+), 31 deletions(-)
