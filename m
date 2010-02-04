From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:37 +0100
Subject: [PATCH] Add USB support for i.MX27/35 and Phytec i.MX boards
Message-ID: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The following patches add platform ehci support for i.MX27 and i.MX35
and USB support for the Phytec i.MX based boards.
Any comments welcome.

Sascha

The following changes since commit 9fd96bbb6a3a1fd9ba24e84a2d7ccc6ccb6beb60:
  Sascha Hauer (1):
        Merge branch 'imx/master' of git://git.pengutronix.de/git/ukl/linux-2.6 into mxc-master

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git phytec-usb

Sascha Hauer (8):
      fsl_mx3_udc: Add i.MX35 support
      i.MX ehci platform support: Some fixes
      i.MX27: Add USB control register access support
      i.MX35: Add USB control register access support
      i.MX27 pca100: Add USB support
      i.MX27 pcm038: Add USB support
      i.MX31 pcm037: Add USB support
      i.MX27 pca100: Add USB support

 arch/arm/mach-mx2/Kconfig                 |    2 +
 arch/arm/mach-mx2/mach-pca100.c           |  103 ++++
 arch/arm/mach-mx2/mach-pcm038.c           |   22 +
 arch/arm/mach-mx3/Kconfig                 |    2 +
 arch/arm/mach-mx3/mach-pcm037.c           |  137 ++++--
 arch/arm/mach-mx3/mach-pcm043.c           |   53 ++
 arch/arm/mach-mx3/pcm037.c                |  795 +++++++++++++++++++++++++++++
 arch/arm/mach-mx3/pcm043.c                |  367 +++++++++++++
 arch/arm/plat-mxc/ehci.c                  |  118 ++++-
 arch/arm/plat-mxc/include/mach/mxc_ehci.h |    4 +
 drivers/usb/gadget/fsl_mx3_udc.c          |   31 +-
 11 files changed, 1570 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/mach-mx3/pcm037.c
 create mode 100644 arch/arm/mach-mx3/pcm043.c
