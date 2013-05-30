From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 30 May 2013 15:20:52 +0530
Subject: [PATCH 0/2] USB: OHCI: Splitting ohci-platform into independent driver
In-Reply-To: <y>
References: <y>
Message-ID: <1369907454-11003-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patch begins the process of splitting ohci-platform up 
into independent driver modules and add a name for the platform-private field.

Patch 1/2 separate ohci-platform into independent driver modules.  
 
Patch 2/2 adds an ohci->priv field for private use by OHCI platform drivers.


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
