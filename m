From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:02 +0530
Subject: [PATCH V2 00/11] USB: OHCI :Properly handle ohci_suspend()routine in
 bus glue
In-Reply-To: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci bus glue was not properly handled as
it was not suspending generic part of ohci controller. Alan Stern suggested,
properly handle ohci suspend scenario.

Calling explicitly the ohci_suspend()routine will ensure proper handling
of suspend scenario.

V1->V2:
      -removed unused do_wakeup parameter.

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

 drivers/usb/host/ohci-at91.c     |    8 +++++---
 drivers/usb/host/ohci-da8xx.c    |   14 ++++++++++----
 drivers/usb/host/ohci-ep93xx.c   |   10 ++++++++--
 drivers/usb/host/ohci-exynos.c   |   19 ++++---------------
 drivers/usb/host/ohci-hcd.c      |   11 +++++++++--
 drivers/usb/host/ohci-omap.c     |   12 +++++++++---
 drivers/usb/host/ohci-platform.c |   10 ++++++++--
 drivers/usb/host/ohci-pxa27x.c   |    8 +++++++-
 drivers/usb/host/ohci-s3c2410.c  |   20 +++-----------------
 drivers/usb/host/ohci-sm501.c    |   10 ++++++++--
 drivers/usb/host/ohci-spear.c    |   11 ++++++++---
 drivers/usb/host/ohci.h          |    2 +-
 12 files changed, 80 insertions(+), 55 deletions(-)

-- 
1.7.9.5
