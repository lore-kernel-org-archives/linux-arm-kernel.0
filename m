From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 12 Apr 2013 13:56:29 +0530
Subject: [GIT PULL FOR v3.10] DaVinci media cleanups + Updates
Message-ID: <CA+V-a8sko61y73odE5efJWwqYyMkBqM7_FPrs7Uvh7sdtBsGvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans/Mauro,

Please pull the following patches for Davinci media. Few patches
contain platform changes for ARM which have been Acked by its maintainer.

Regards,
--Prabhakar Lad

The following changes since commit 81e096c8ac6a064854c2157e0bf802dc4906678c:

  [media] budget: Add support for Philips Semi Sylt PCI ref. design
(2013-04-08 07:28:01 -0300)

are available in the git repository at:
  git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git for_v3.10

Lad, Prabhakar (6):
      davinci: vpif: add pm_runtime support
      media: davinci: vpss: enable vpss clocks
      media: davinci: vpbe: venc: move the enabling of vpss clocks to driver
      davinic: vpss: trivial cleanup
      ARM: davinci: dm365: add support for v4l2 video display
      ARM: davinci: dm365 EVM: add support for VPBE display

Sekhar Nori (1):
      media: davinci: kconfig: fix incorrect selects

 arch/arm/mach-davinci/board-dm365-evm.c      |  166 ++++++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h              |    8 +-
 arch/arm/mach-davinci/dm355.c                |    7 +-
 arch/arm/mach-davinci/dm365.c                |  195 +++++++++++++++++++++++---
 arch/arm/mach-davinci/dm644x.c               |    9 +-
 arch/arm/mach-davinci/pm_domain.c            |    2 +-
 drivers/media/platform/davinci/Kconfig       |  103 +++++---------
 drivers/media/platform/davinci/Makefile      |   17 +--
 drivers/media/platform/davinci/dm355_ccdc.c  |   39 +-----
 drivers/media/platform/davinci/dm644x_ccdc.c |   44 ------
 drivers/media/platform/davinci/isif.c        |   28 +---
 drivers/media/platform/davinci/vpbe_venc.c   |   25 ++++
 drivers/media/platform/davinci/vpif.c        |   24 +---
 drivers/media/platform/davinci/vpss.c        |   36 ++++-
 14 files changed, 459 insertions(+), 244 deletions(-)
