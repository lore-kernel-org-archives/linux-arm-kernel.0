From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:58:16 +0530
Subject: [PATCH 0/6] mmc: Handle platform_get_irq's error checking and return
Message-ID: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct and and we must check its return value.

Arvind Yadav (6):
  [PATCH 1/6] mmc: meson-gx-mmc: Fix platform_get_irq's error checking
  [PATCH 2/6] mmc: s3cmci: Fix platform_get_irq's error checking
  [PATCH 3/6] mmc: sdhci-acpi: Handle return value of platform_get_irq
  [PATCH 4/6] mmc: sdhci-spear: Handle return value of platform_get_irq
  [PATCH 5/6] mmc: sh_mmcif: Handle return value of platform_get_irq
  [PATCH 6/6] mmc: sunxi-mmc: Handle return value of platform_get_irq

 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 drivers/mmc/host/s3cmci.c       | 4 ++--
 drivers/mmc/host/sdhci-acpi.c   | 4 ++++
 drivers/mmc/host/sdhci-spear.c  | 4 ++++
 drivers/mmc/host/sh_mmcif.c     | 2 +-
 drivers/mmc/host/sunxi-mmc.c    | 5 +++++
 6 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.7.4
