From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 15 Jul 2010 16:10:43 +0300
Subject: [PATCH 0/3] Enable pxa310 usb otg port host mode
Message-ID: <1279199446-30526-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduces the U2D Controller and
Host driver for PXA3xx and enables cm-x300 usb host port2.

This patch series depends on
"Generic ULPI driver extention" patch series,
which is currently sent for review to
linux-usb at vger.kernel.org mailing list

Igor Grinberg (3):
  [ARM] pxa3xx: Add U2D controller and driver
  [ARM] usb/host/ohci-pxa27x: enable OHCI over U2DC
  [ARM] pxa/cm-x300: enable USB host port2

 arch/arm/mach-pxa/Kconfig                   |    4 +
 arch/arm/mach-pxa/Makefile                  |    2 +-
 arch/arm/mach-pxa/cm-x300.c                 |   77 ++++++
 arch/arm/mach-pxa/devices.c                 |   28 ++
 arch/arm/mach-pxa/devices.h                 |    1 +
 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h |   35 +++
 arch/arm/mach-pxa/pxa3xx-u2d.c              |  392 +++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c                  |    2 +-
 drivers/usb/host/ohci-pxa27x.c              |    7 +
 9 files changed, 546 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
 create mode 100644 arch/arm/mach-pxa/pxa3xx-u2d.c
