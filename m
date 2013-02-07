From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Thu,  7 Feb 2013 23:03:57 +0530
Subject: [PATCH 00/10] usb: ehci: more bus glues as separate modules
In-Reply-To: <yes>
References: <yes>
Message-ID: <5113e5b1.c84e420a.08c3.ffffbe1b@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>


Separate the SOC On-Chip host controller driver from ehci-hcd
host code into its own driver module.

Manjunath Goudar (10):
  USB:Changed omap2plus_defconfig to support OMAP USB static driver
  USB: EHCI: make ehci-omap a separate driver
  USB: EHCI: make ehci-spear a separate driver
  USB: EHCI: make ehci-orion a separate driver
  USB: EHCI: make ehci-atmel a separate driver
  USB: EHCI: make ehci-s5p a separate driver
  USB: EHCI: make ehci-mv a separate driver
  USB: EHCI: make ehci-vt8500 a separate driver
  USB: EHCI: make ehci-msm a separate driver
  USB: EHCI: make ehci-w90X900 a separate driver

 arch/arm/configs/omap2plus_defconfig |    4 ++
 drivers/usb/host/Kconfig             |   43 ++++++++++++---
 drivers/usb/host/Makefile            |   10 +++-
 drivers/usb/host/ehci-atmel.c        |   78 ++++++++++++++-------------
 drivers/usb/host/ehci-hcd.c          |   75 +++++++-------------------
 drivers/usb/host/ehci-msm.c          |   84 +++++++++++++----------------
 drivers/usb/host/ehci-mv.c           |   81 +++++++++++++---------------
 drivers/usb/host/ehci-omap.c         |   69 ++++++++++--------------
 drivers/usb/host/ehci-orion.c        |   98 +++++++++++++++++-----------------
 drivers/usb/host/ehci-s5p.c          |   69 +++++++++++++-----------
 drivers/usb/host/ehci-spear.c        |   77 +++++++++++++-------------
 drivers/usb/host/ehci-vt8500.c       |   73 ++++++++++++-------------
 drivers/usb/host/ehci-w90x900.c      |   90 ++++++++++++++-----------------
 13 files changed, 415 insertions(+), 436 deletions(-)

-- 
1.7.9.5
