From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 5 Mar 2015 07:59:04 -0800
Subject: [PATCH RESEND 0/4] Add support for IPROC SDHCI controller
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1425571148-5876-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patchsets contains the IPROC SDHCI driver used
in a series of Broadcom SoCs
Quirks are also added to support this controller.

Corneliu Doban (1):
  mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53

Scott Branden (3):
  mmc: sdhci: add quirk for ACMD23 broken
  mmc: sdhci-iproc: add IPROC SDHCI driver
  mmc: sdhci-iproc: add device tree bindings

 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  23 ++
 drivers/mmc/host/Kconfig                           |  14 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-iproc.c                     | 241 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   7 +-
 include/linux/mmc/sdhci.h                          |   2 +
 6 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
 create mode 100644 drivers/mmc/host/sdhci-iproc.c

-- 
2.2.2
