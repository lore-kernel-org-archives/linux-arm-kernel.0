From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 15:01:29 +0100
Subject: [PATCH] i.MX51: Full iomux support
Message-ID: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series picks up the patch from Lothar Wa?mann replacing
the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
support based on this patch.
The iomux configurations are taken from the Freescale pinmux tool, so the
definitions should be rather complete. Anyway, there are some modes
not present in the tool.
I took the padmux settings from the old iomux support where present.
This series was tested on the babbage board, but due to the mass of defines
they are of course not completely tested, so please test yourself if
your board still works.

Sascha

The following changes since commit 28a4f908acb342350b9ecbfcdf0a999cb83e05aa:

  ARM: mx5: check for error in ioremap (2010-12-14 09:55:53 +0100)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git iomux-v3

Lothar Wa?mann (1):
      MXC IOMUX-V3 replace struct pad_desc with bitmapped cookie (step 2)

Sascha Hauer (1):
      ARM i.MX51: Full iomux support

 arch/arm/mach-mx3/mach-pcm043.c              |   14 +-
 arch/arm/mach-mx5/board-cpuimx51.c           |   14 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c         |   32 +-
 arch/arm/mach-mx5/board-mx51_3ds.c           |    4 +-
 arch/arm/mach-mx5/board-mx51_babbage.c       |   46 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c       |   22 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |   10 +-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |    9 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h  | 1904 +++++++++++++++++++++-----
 arch/arm/plat-mxc/include/mach/iomux-v3.h    |   92 +-
 arch/arm/plat-mxc/iomux-v3.c                 |   25 +-
 11 files changed, 1668 insertions(+), 504 deletions(-)
