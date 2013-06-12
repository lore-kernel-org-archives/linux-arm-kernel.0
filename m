From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 12 Jun 2013 20:58:28 +0530
Subject: [PATCH 00/10] USB: OHCI:Properly handle ohci_suspend()routine in bus
 glue
Message-ID: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci bus glue was not properly handled as 
it was not suspending generic part of ohci controller. Calling 
explicitly the ohci_suspend()routine will ensure proper handling 
of suspend scenario.
 
Manjunath Goudar (10):
  USB: OHCI: Properly handle ohci-at91 suspend
  USB: OHCI: Properly handle ohci-s3c2410 suspend
  USB: OHCI: Properly handle ohci-da8xx suspend
  USB: OHCI: Properly handle ohci-ep93xx suspend
  USB: OHCI: Properly handle ohci-exynos suspend
  USB: OHCI: Properly handle ohci-omap suspend
  USB: OHCI: Properly handle ohci-platform suspend
  USB: OHCI: Properly handle ohci-pxa27x suspend
  USB: OHCI: Properly handle ohci-sm501 suspend
  USB: OHCI: Properly handle ohci-spear suspend

 drivers/usb/host/ohci-at91.c     |    8 ++++++--
 drivers/usb/host/ohci-da8xx.c    |   13 +++++++++----
 drivers/usb/host/ohci-ep93xx.c   |    6 +++++-
 drivers/usb/host/ohci-exynos.c   |    3 +++
 drivers/usb/host/ohci-omap.c     |   11 ++++++++---
 drivers/usb/host/ohci-platform.c |    6 +++++-
 drivers/usb/host/ohci-pxa27x.c   |    6 +++++-
 drivers/usb/host/ohci-s3c2410.c  |    3 +++
 drivers/usb/host/ohci-sm501.c    |    9 +++++++--
 drivers/usb/host/ohci-spear.c    |   10 +++++++---
 10 files changed, 58 insertions(+), 17 deletions(-)

-- 
1.7.9.5
