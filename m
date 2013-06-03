From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon,  3 Jun 2013 20:44:14 +0530
Subject: [PATCH V3 0/2] USB: OHCI: Splitting ohci-platform into independent
 driver
In-Reply-To: <1369907454-11003-2-git-send-email-manjunath.goudar@linaro.org>
References: <1369907454-11003-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1370272457-25983-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patch begins the process of splitting ohci-platform up
into independent driver modules and add a name for the platform-private field.

Patch 1/2 separate ohci-platform into independent driver modules.

V2 to V3:
Directly Passed "hcd" argument without calling ohci_to_hcd() function.

Patch 2/2 adds an ohci->priv field for private use by OHCI platform drivers.
V2 to V3:
No changes.
 
Manjunath Goudar (2):
  USB: OHCI: make ohci-platform a separate driver
  USB: OHCI: add a name for the platform-private field

 drivers/usb/host/Kconfig         |    2 +-
 drivers/usb/host/Makefile        |    1 +
 drivers/usb/host/ohci-hcd.c      |    6 +--
 drivers/usb/host/ohci-platform.c |   88 ++++++++++++++++++--------------------
 drivers/usb/host/ohci.h          |    3 ++
 5 files changed, 47 insertions(+), 53 deletions(-)

-- 
1.7.9.5
