From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 Jul 2010 23:59:50 +0200
Subject: [PATCH 0/5] add flexcan support to i.mx
Message-ID: <1279749595-21596-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series of patches prepares the i.mx tree for the flexcan driver.
Clock support is added or adjusted. The last patch registers flexcan on
the pcm043.

This series of patches applies to the sha's "imx/linux-2.6.git imx-for-2.6.36"
tree and is available at:
git://git.pengutronix.de/git/mkl/linux-2.6.git for-imx-for-2.6.36

The actual flexcan driver is going over the net-next-2.6 tree and is currently
in the (hopefully) final round of review, it is available at:
git://git.pengutronix.de/git/mkl/linux-2.6.git for-net-next-2.6

The combination (current mainline + for-net-next-2.6 + for-imx-for-2.6.36)
has been successfully tested on the pcm043 (i.mx35).

please consider to apply
Cheers, Marc


P.S.: this can be pulled:

The following changes since commit 10fda3e745c337332a58ce1c43704d7af3eb79fd:

  eukrea_mbimx27-baseboard: fix compile when CONFIG_SPI_IMX is disabled (2010-07-20 08:33:00 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/mkl/linux-2.6.git for-imx-for-2.6.36

Marc Kleine-Budde (3):
      mx35: adjust flexcan clock definition
      mx35: add flexcan devices
      pcm043: register flexcan device

Sascha Hauer (2):
      mx25: flexcan clock support
      mx25: Add flexcan devices

 arch/arm/mach-mx25/clock.c      |    4 ++
 arch/arm/mach-mx25/devices.c    |   95 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx25/devices.h    |    2 +
 arch/arm/mach-mx3/clock-imx35.c |    4 +-
 arch/arm/mach-mx3/devices.c     |   40 ++++++++++++++++
 arch/arm/mach-mx3/devices.h     |    2 +
 arch/arm/mach-mx3/mach-pcm043.c |    4 ++
 7 files changed, 149 insertions(+), 2 deletions(-)
