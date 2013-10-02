From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed,  2 Oct 2013 15:45:36 +0530
Subject: [PATCH 00/11] USB: OHCI:Properly handle ohci_suspend()routine in bus
 glue
Message-ID: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci bus glue was not properly handled as
it was not suspending generic part of ohci controller. Alan Stern suggested, 
properly handle ohci suspend scenario. 

Calling explicitly the ohci_suspend()routine will ensure proper handling
of suspend scenario.
 

*** BLURB HERE ***

Manjunath Goudar (11):
  USB: OHCI: Properly handle OHCI controller suspend
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

 drivers/usb/host/ohci-at91.c     |   10 ++++++++--
 drivers/usb/host/ohci-da8xx.c    |   15 +++++++++++----
 drivers/usb/host/ohci-ep93xx.c   |   11 +++++++++--
 drivers/usb/host/ohci-exynos.c   |   20 +++++---------------
 drivers/usb/host/ohci-hcd.c      |    9 ++++++++-
 drivers/usb/host/ohci-omap.c     |   13 ++++++++++---
 drivers/usb/host/ohci-platform.c |   11 +++++++++--
 drivers/usb/host/ohci-pxa27x.c   |    9 ++++++++-
 drivers/usb/host/ohci-s3c2410.c  |   21 ++++-----------------
 drivers/usb/host/ohci-sm501.c    |   11 +++++++++--
 drivers/usb/host/ohci-spear.c    |   12 +++++++++---
 11 files changed, 90 insertions(+), 52 deletions(-)

-- 
1.7.9.5
