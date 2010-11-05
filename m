From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:46:04 +0100
Subject: i.MX patches for next
Message-ID: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 255ed73db5c48bcdda69aac642e265fde60564e5:

  imx: remove deprecated symbols as all users are gone now (2010-11-05 09:12:31 +0100)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-pu

Sascha Hauer (7):
      ARM i.MX51 boards: Do not use PHYS_OFFSET
      ARM i.MX irq: Compile avic irq code only on SoCs that need it
      ARM i.MX51: Make CONFIG_MXC_TZIC an invisible option
      ARM i.MX irq: Allow runtime decision between AVIC and TZIC
      ARM i.MX DMA: return gracefully on different socs
      ARM i.MX51: return gracefully on different socs
      ARM i.MX27 pm: return gracefully on different socs

 arch/arm/mach-imx/Kconfig                    |    3 +
 arch/arm/mach-imx/dma-v1.c                   |    2 +-
 arch/arm/mach-imx/pm-imx27.c                 |    3 +
 arch/arm/mach-mx3/Kconfig                    |    2 +
 arch/arm/mach-mx5/board-cpuimx51.c           |    2 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    2 +-
 arch/arm/mach-mx5/board-mx51_3ds.c           |    2 +-
 arch/arm/mach-mx5/cpu.c                      |    3 +
 arch/arm/plat-mxc/Kconfig                    |   11 ++--
 arch/arm/plat-mxc/Makefile                   |    3 +-
 arch/arm/plat-mxc/{irq.c => avic.c}          |    2 +
 arch/arm/plat-mxc/cpu.c                      |    3 +
 arch/arm/plat-mxc/include/mach/entry-macro.S |   66 ++++++++++++++++----------
 arch/arm/plat-mxc/include/mach/mxc.h         |    8 +++
 arch/arm/plat-mxc/tzic.c                     |    3 +
 15 files changed, 79 insertions(+), 36 deletions(-)
 rename arch/arm/plat-mxc/{irq.c => avic.c} (98%)
