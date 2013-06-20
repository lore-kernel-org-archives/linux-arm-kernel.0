From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 20 Jun 2013 15:05:56 +0530
Subject: [PATCH V4 00/11] USB: OHCI:Properly handle ohci_suspend()routine in
 bus glue
In-Reply-To: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci bus glue was not properly handled as
it was not suspending generic part of ohci controller. Calling
explicitly the ohci_suspend()routine will ensure proper handling
of suspend scenario.

V2:
 -Incase ohci_suspend() fails, return right away without executing further.

V3:
 -New patch 1/11 added, for generic ohci-hcd suspend code.
 
V4:
 -Properly aligned "do_wakeup" and "ret" variables.

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
 drivers/usb/host/ohci-ep93xx.c   |    9 ++++++++-
 drivers/usb/host/ohci-exynos.c   |   20 +++++---------------
 drivers/usb/host/ohci-hcd.c      |    9 ++++++++-
 drivers/usb/host/ohci-omap.c     |   13 ++++++++++---
 drivers/usb/host/ohci-platform.c |    9 ++++++++-
 drivers/usb/host/ohci-pxa27x.c   |    8 +++++++-
 drivers/usb/host/ohci-s3c2410.c  |   19 ++++---------------
 drivers/usb/host/ohci-sm501.c    |   11 +++++++++--
 drivers/usb/host/ohci-spear.c    |   12 +++++++++---
 11 files changed, 87 insertions(+), 48 deletions(-)

-- 
1.7.9.5
