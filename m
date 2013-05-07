From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue,  7 May 2013 15:20:51 +0530
Subject: [RFC PATCH 0/2] USB: OHCI: Start splitting up the driver
In-Reply-To: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1367920253-15207-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches begins the process of splitting ohci-hcd up into
a core library module and independent pci driver modules.

Patch 1/2 prepares the way by exporting a few functions from ohci-hcd
and adding a new mechanism for platform-specific drivers to initialize
their hc_driver structures.  This deserves to be done in the core
because almost all of the entries in these structures are pure
boilerplate -- practically none of the drivers need to override more
than three of the standard core values.

Patch 2/2  separate out ohci-pci into independent driver modules.

Manjunath Goudar (2):
  USB: OHCI: prepare to make ohci-hcd a library module
  USB: OHCI: make ohci-pci a separate driver

 drivers/usb/host/Kconfig         |    9 ++-
 drivers/usb/host/Makefile        |    3 +
 drivers/usb/host/ohci-hcd.c      |  142 +++++++++++++++++++++++++++++---------
 drivers/usb/host/ohci-pci.c      |  129 ++++++++++------------------------
 drivers/usb/host/ohci-platform.c |    2 +-
 drivers/usb/host/ohci-q.c        |   13 ++++
 drivers/usb/host/ohci.h          |   30 +++++++-
 7 files changed, 197 insertions(+), 131 deletions(-)

-- 
1.7.9.5
