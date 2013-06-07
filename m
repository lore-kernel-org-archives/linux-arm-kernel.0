From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri,  7 Jun 2013 11:33:26 +0530
Subject: [RFC][PATCH 0/7] USB: OHCI: more bus glues as separate modules
Message-ID: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are for separating the SOC On-Chip ohci host controller 
from ohci-hcd host code into its own driver module.
This work is part of enabling multi-platform kernels on ARM.

Manjunath Goudar (7):
  USB: OHCI: make ohci-exynos a separate driver
  USB: OHCI: make ohci-omap a separate driver
  USB: OHCI: make ohci-omap3 a separate driver
  USB: OHCI: make ohci-spear a separate driver
  USB: OHCI: export ohci_hub_control and ohci_hub_status_data
  USB: OHCI: make ohci-at91 a separate driver
  USB: OHCI: make ohci-s3c2410 a separate driver

 drivers/usb/host/Kconfig        |   30 +++++++-
 drivers/usb/host/Makefile       |    6 ++
 drivers/usb/host/ohci-at91.c    |  135 +++++++++++++++-------------------
 drivers/usb/host/ohci-exynos.c  |  154 +++++++++++++++++----------------------
 drivers/usb/host/ohci-hcd.c     |  122 ++-----------------------------
 drivers/usb/host/ohci-hub.c     |    8 +-
 drivers/usb/host/ohci-omap.c    |  142 +++++++++++++-----------------------
 drivers/usb/host/ohci-omap3.c   |  122 +++++++++++--------------------
 drivers/usb/host/ohci-s3c2410.c |  116 ++++++++++++-----------------
 drivers/usb/host/ohci-spear.c   |  149 ++++++++++++++++---------------------
 drivers/usb/host/ohci.h         |    9 +++
 11 files changed, 383 insertions(+), 610 deletions(-)

-- 
1.7.9.5
