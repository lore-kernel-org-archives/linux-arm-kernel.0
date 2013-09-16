From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon, 16 Sep 2013 15:40:05 +0530
Subject: [PATCH V5 0/9]  USB: OHCI: more bus glues as separate modules
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1379326215-23047-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are for separating the SOC On-Chip ohci host controller
from ohci-hcd host code and making per SOC driver module similar to EHCI 
module available in the kernel. This work is part of enabling multi-platform 
kernel on ARM.
 
Before I was sending three different ohci patch set as below.
 1. Six series patch set is having exynos, omap, omap3, spear, at91 and s3c2410.
 2. ohci-nxp a separate driver patch.
 3. Two series patch set is having ep93xx and pxa27x.
In this patch set all three previous ohci series have been combined into single 
series as all these patches are related to OHCI.



Manjunath Goudar (9):
  USB: OHCI: make ohci-exynos a separate driver
  USB: OHCI: make ohci-omap a separate driver
  USB: OHCI: make ohci-omap3 a separate driver
  USB: OHCI: make ohci-spear a separate driver
  USB: OHCI: make ohci-at91 a separate driver
  USB: OHCI: make ohci-s3c2410 a separate driver
  USB: OHCI: make ohci-nxp a separate driver
  USB: OHCI: make ohci-ep93xx a separate driver
  USB: OHCI: make ohci-pxa27x a separate driver

 drivers/usb/host/Kconfig        |   56 ++++++++-
 drivers/usb/host/Makefile       |    9 ++
 drivers/usb/host/ohci-at91.c    |  156 ++++++++++++-------------
 drivers/usb/host/ohci-ep93xx.c  |   72 +++++-------
 drivers/usb/host/ohci-exynos.c  |  167 +++++++++++----------------
 drivers/usb/host/ohci-hcd.c     |  149 ------------------------
 drivers/usb/host/ohci-nxp.c     |  123 ++++++++------------
 drivers/usb/host/ohci-omap.c    |  156 +++++++++----------------
 drivers/usb/host/ohci-omap3.c   |  118 +++++++------------
 drivers/usb/host/ohci-pxa27x.c  |  240 +++++++++++++++++----------------------
 drivers/usb/host/ohci-s3c2410.c |  128 ++++++++++-----------
 drivers/usb/host/ohci-spear.c   |  140 +++++++++--------------
 12 files changed, 587 insertions(+), 927 deletions(-)

-- 
1.7.9.5
