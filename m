From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu,  4 Jul 2013 22:46:25 +0530
Subject: [PATCH 0/2] USB: OHCI: more bus glues as separate modules
Message-ID: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are for separating the SOC On-Chip ohci host controller
from ohci-hcd host code into its own driver module.
This work is part of enabling multi-platform kernels on ARM.

Manjunath Goudar (2):
  USB: OHCI: make ohci-ep93xx a separate driver
  USB: OHCI: make ohci-pxa27x a separate driver

 drivers/usb/host/Kconfig       |   16 +++++
 drivers/usb/host/Makefile      |    2 +
 drivers/usb/host/ohci-ep93xx.c |   84 ++++++++++------------
 drivers/usb/host/ohci-hcd.c    |   24 -------
 drivers/usb/host/ohci-pxa27x.c |  154 ++++++++++++++++------------------------
 5 files changed, 120 insertions(+), 160 deletions(-)

-- 
1.7.9.5
