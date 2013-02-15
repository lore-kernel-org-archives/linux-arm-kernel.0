From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri, 15 Feb 2013 15:54:05 +0530
Subject: [V2 0/8] usb: ehci: more bus glues as separate modules
Message-ID: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the SOC On-Chip host controller driver from ehci-hcd
host code into its own driver module

V2:
Modified the patches, based on the first version review comments  

Manjunath Goudar (8):
  USB: EHCI: make ehci-spear a separate driver
  USB: EHCI: make ehci-atmel a separate driver
  USB: EHCI: make ehci-s5p a separate driver
  USB: EHCI: make ehci-mv as separate static driver
  USB: EHCI: make ehci-vt8500 a separate driver
  USB: EHCI: make ehci-msm a separate driver
  USB: EHCI: make ehci-w90X900 a separate driver
  USB: EHCI: make ehci-orion a separate driver

 drivers/usb/host/Kconfig        |   40 +++++++++++++++--
 drivers/usb/host/Makefile       |    9 +++-
 drivers/usb/host/ehci-atmel.c   |   76 ++++++++++++++++----------------
 drivers/usb/host/ehci-hcd.c     |   52 +++++-----------------
 drivers/usb/host/ehci-msm.c     |   85 ++++++++++++++++--------------------
 drivers/usb/host/ehci-mv.c      |   78 +++++++++++++++------------------
 drivers/usb/host/ehci-orion.c   |   90 ++++++++++++++++++--------------------
 drivers/usb/host/ehci-s5p.c     |   67 +++++++++++++++-------------
 drivers/usb/host/ehci-spear.c   |   77 +++++++++++++++++----------------
 drivers/usb/host/ehci-vt8500.c  |   73 ++++++++++++++-----------------
 drivers/usb/host/ehci-w90x900.c |   91 +++++++++++++++++----------------------
 drivers/usb/host/ehci.h         |    2 +-
 12 files changed, 358 insertions(+), 382 deletions(-)

-- 
1.7.9.5
