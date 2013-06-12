From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 12 Jun 2013 21:23:56 +0530
Subject: [PATCH V2 0/6] USB: OHCI: more bus glues as separate modules
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371052442-14541-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are for separating the SOC On-Chip ohci host controller
from ohci-hcd host code into its own driver module.
This work is part of enabling multi-platform kernels on ARM.

V2:
  In patch 5/6 and 6/6:
  -Set non-standard fields in hc_driver manually, rather than
   relying on an expanded struct ohci_driver_overrides.
  -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
   relying on ohci_hub_control and hub_status_data being exported.
  -ohci_setup() has been removed because it is called in .reset member
   of the ohci_hc_driver structure.
 
  In patch 1/6 to 4/6
  -ohci_setup() has been removed because it is called in .reset member
   of the ohci_hc_driver structure.

Manjunath Goudar (6):
  USB: OHCI: make ohci-exynos a separate driver
  USB: OHCI: make ohci-omap a separate driver
  USB: OHCI: make ohci-omap3 a separate driver
  USB: OHCI: make ohci-spear a separate driver
  USB: OHCI: make ohci-at91 a separate driver
  USB: OHCI: make ohci-s3c2410 a separate driver

 drivers/usb/host/Kconfig        |   30 ++++++-
 drivers/usb/host/Makefile       |    6 ++
 drivers/usb/host/ohci-at91.c    |  148 +++++++++++++++-------------------
 drivers/usb/host/ohci-exynos.c  |  167 ++++++++++++++++-----------------------
 drivers/usb/host/ohci-hcd.c     |  108 -------------------------
 drivers/usb/host/ohci-omap.c    |  156 ++++++++++++------------------------
 drivers/usb/host/ohci-omap3.c   |  120 ++++++++++------------------
 drivers/usb/host/ohci-s3c2410.c |  129 ++++++++++++++----------------
 drivers/usb/host/ohci-spear.c   |  140 +++++++++++++-------------------
 9 files changed, 370 insertions(+), 634 deletions(-)

-- 
1.7.9.5
