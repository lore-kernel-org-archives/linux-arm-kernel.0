From: manjunath.goudar@linaro.org (manjunath.goudar at linaro.org)
Date: Fri, 31 May 2013 17:38:38 +0530
Subject: [PATCH V2 0/2] USB: OHCI: Splitting ohci-platform into independent
 driver
In-Reply-To: <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
References: <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <51a892d6.3077420a.5699.0f80@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

This series patch begins the process of splitting ohci-platform up
into independent driver modules and add a name for the platform-private field.

Patch 1/2 separate ohci-platform into independent driver modules.

V1 to V2:
Passed "hcd" argment instead of "ohci" in ohci_setup().

Patch 2/2 adds an ohci->priv field for private use by OHCI platform drivers.
V1 to V2:
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
