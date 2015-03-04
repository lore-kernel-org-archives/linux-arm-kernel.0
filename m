From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 4 Mar 2015 12:42:12 -0800
Subject: [PATCH v3 0/2] Add support for Broadcom RNG200
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1425501734-14025-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patchsets contains the Broadcom Random Number Generator
driver and device tree binding documentation.

Changes from v2:
 added usleep_range instead of cpu_relax
 add init and cleanup functions following new hwrng model
 
Changes from v1:
 added \n to 2 dev_err messages

Scott Branden (2):
  hwrng: iproc-rng200 - Add device tree bindings
  hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver

 .../bindings/hwrng/brcm,iproc-rng200.txt           |  12 +
 drivers/char/hw_random/Kconfig                     |  13 ++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/iproc-rng200.c              | 254 +++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/brcm,iproc-rng200.txt
 create mode 100644 drivers/char/hw_random/iproc-rng200.c

-- 
2.3.0
