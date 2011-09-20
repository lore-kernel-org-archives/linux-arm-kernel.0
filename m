From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 14:49:12 +0200
Subject: [PATCH] i.MX: use CONFIG_MULTI_IRQ_HANDLER
Message-ID: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series switches the i.MX architecture to use
CONFIG_MULTI_IRQ_HANDLER. This allows us to compile a kernel
with i.MX3 and i.MX5 support in a later series. Also, it will
help with the i.MX6 support which has a different irq controller.

Tested on i.MX27, i.MX35 and i.MX51.

Sascha

Sascha Hauer (4):
      ARM i.MX avic: add handle_irq function
      ARM i.MX tzic: add handle_irq function
      ARM i.MX boards: use CONFIG_MULTI_IRQ_HANDLER
      ARM i.MX entry-macro.S: remove now unused code

 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-imx/mach-apf9328.c             |    1 +
 arch/arm/mach-imx/mach-armadillo5x0.c        |    1 +
 arch/arm/mach-imx/mach-bug.c                 |    1 +
 arch/arm/mach-imx/mach-cpuimx27.c            |    1 +
 arch/arm/mach-imx/mach-cpuimx35.c            |    1 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c     |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    1 +
 arch/arm/mach-imx/mach-imx27ipcam.c          |    1 +
 arch/arm/mach-imx/mach-imx27lite.c           |    1 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c        |    1 +
 arch/arm/mach-imx/mach-mx1ads.c              |    2 +
 arch/arm/mach-imx/mach-mx21ads.c             |    1 +
 arch/arm/mach-imx/mach-mx25_3ds.c            |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c            |    1 +
 arch/arm/mach-imx/mach-mx27ads.c             |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c            |    1 +
 arch/arm/mach-imx/mach-mx31ads.c             |    1 +
 arch/arm/mach-imx/mach-mx31lilly.c           |    1 +
 arch/arm/mach-imx/mach-mx31lite.c            |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c         |    1 +
 arch/arm/mach-imx/mach-mx35_3ds.c            |    1 +
 arch/arm/mach-imx/mach-mxt_td60.c            |    1 +
 arch/arm/mach-imx/mach-pca100.c              |    1 +
 arch/arm/mach-imx/mach-pcm037.c              |    1 +
 arch/arm/mach-imx/mach-pcm038.c              |    1 +
 arch/arm/mach-imx/mach-pcm043.c              |    1 +
 arch/arm/mach-imx/mach-qong.c                |    1 +
 arch/arm/mach-imx/mach-scb9328.c             |    1 +
 arch/arm/mach-imx/mach-vpr200.c              |    1 +
 arch/arm/mach-mx5/board-cpuimx51.c           |    1 +
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    1 +
 arch/arm/mach-mx5/board-mx50_rdp.c           |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c           |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c       |    1 +
 arch/arm/mach-mx5/board-mx51_efikamx.c       |    1 +
 arch/arm/mach-mx5/board-mx51_efikasb.c       |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c           |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c          |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c           |    1 +
 arch/arm/plat-mxc/avic.c                     |   13 ++++++
 arch/arm/plat-mxc/include/mach/common.h      |   14 ++++++
 arch/arm/plat-mxc/include/mach/entry-macro.S |   58 +-------------------------
 arch/arm/plat-mxc/tzic.c                     |   24 ++++++++++-
 45 files changed, 93 insertions(+), 58 deletions(-)
