From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Mon, 11 Feb 2013 00:28:09 +0530
Subject: [PATCH 0/8] usb: ehci: more bus glues as separate modules
In-Reply-To: <y>
References: <y>
Message-ID: <5117edda.860e440a.097c.3507@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Separate the SOC On-Chip host controller driver from ehci-hcd 
host code into its own driver module

Manjunath Goudar (8):
  USB: EHCI: make ehci-spear a separate driver
  USB: EHCI: make ehci-atmel a separate driver
  USB: EHCI: make ehci-s5p a separate driver
  USB: EHCI: make ehci-mv a separate driver
  USB: EHCI: make ehci-vt8500 a separate driver
  USB: EHCI: make ehci-msm a separate driver
  USB: EHCI: make ehci-w90X900 a separate driver
  USB: EHCI: make ehci-orion a separate driver

 drivers/usb/host/Kconfig        |   42 +++++++++++--
 drivers/usb/host/Makefile       |    9 ++-
 drivers/usb/host/ehci-atmel.c   |   77 ++++++++++++-----------
 drivers/usb/host/ehci-hcd.c     |   52 +++-------------
 drivers/usb/host/ehci-msm.c     |   85 +++++++++++--------------
 drivers/usb/host/ehci-mv.c      |   80 +++++++++++-------------
 drivers/usb/host/ehci-orion.c   |   91 +++++++++++++--------------
 drivers/usb/host/ehci-s5p.c     |   69 ++++++++++++---------
 drivers/usb/host/ehci-spear.c   |  131 ++++++++++++++++++++-------------------
 drivers/usb/host/ehci-vt8500.c  |   73 ++++++++++------------
 drivers/usb/host/ehci-w90x900.c |   90 ++++++++++++---------------
 drivers/usb/host/ehci.h         |    2 +-
 12 files changed, 392 insertions(+), 409 deletions(-)

-- 
1.7.9.5
