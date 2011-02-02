From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed,  2 Feb 2011 13:50:28 +0100
Subject: [PATCH 0/2] ARM: mxs: add flexcan support
Message-ID: <1296651030-30792-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch series adds support for freescale's flexcan core to the mx28
architecture. The flexcan can driver supports mx28 without any modifications.

This series has been successfully tested on a Ka-Ro tx28 board.

It's based on Sascha's imx-for-2.6.39 tree and can be pulled from:

The following changes since commit df42c8a720ff2e0d52d187bb1120339e79f58604:

  ARM: mx5/board-mx53_evk.c: Make UART1 functional (2011-02-01 10:26:12 +0100)

are available in the git repository at:
  git://git.pengutronix.de/git/mkl/linux-2.6.git imx-for-2.6.39/msx-flexcan

Marc Kleine-Budde (2):
      ARM: mxs: adjust flexcan clock definition
      ARM: mxs: dynamically register flexcan devices for mx28

 arch/arm/mach-mxs/clock-mx28.c                  |    4 +-
 arch/arm/mach-mxs/devices-mx28.h                |    6 +++
 arch/arm/mach-mxs/devices/Kconfig               |    4 ++
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-flexcan.c    |   51 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +++++
 6 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-flexcan.c

regards, Marc
