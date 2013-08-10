From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Sat, 10 Aug 2013 13:11:38 +0530
Subject: [PATCH V3 0/2] USB: OHCI: more bus glues as separate modules
In-Reply-To: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
References: <1372958187-4039-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1376120501-21368-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are for separating the SOC On-Chip ohci host controller
from ohci-hcd host code into its own driver module.
This work is part of enabling multi-platform kernels on ARM.

In V2:

patch 1/2:
     -ohci_hcd_init() statements are removed,
      because by default it is called in ohci_setup().

Patch 2/2:
     -Changed ohci_hcd and pxa27x_ohci struct variable names.
        1 ohci_hcd struct variable name is ohci.
        2 pxa27x_ohci struct variable name is pxa_ohci.

In V3:

Patch 1/2:
     -Unused *ohci variable has been removed.

patch 2/2:
     -Rewrite the macro definition of to_pxa27x_ohci.
     -clk_put() function has been called before usb_put_hcd().

Manjunath Goudar (2):
  USB: OHCI: make ohci-ep93xx a separate driver
  USB: OHCI: make ohci-pxa27x a separate driver

 drivers/usb/host/Kconfig       |   16 +++
 drivers/usb/host/Makefile      |    2 +
 drivers/usb/host/ohci-ep93xx.c |   80 ++++++-------
 drivers/usb/host/ohci-hcd.c    |   23 ----
 drivers/usb/host/ohci-pxa27x.c |  242 ++++++++++++++++++----------------------
 5 files changed, 158 insertions(+), 205 deletions(-)

-- 
1.7.9.5
