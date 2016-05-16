From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 15 May 2016 22:13:33 -0400
Subject: [PATCH V5 0/6] vfio, platform: add ACPI support
Message-ID: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree code checks for the presence of a reset driver and calls
the of_reset function pointer by looking up the reset driver as a module.

ACPI defines _RST method to perform device level reset. After the _RST
method is executed, the OS can resume using the device.

This patch checks the presence of _RST method and calls the _RST
method when reset is requested.

Changes:
1. No functional changes. Just divide the patches into subpatches for easy
review.

Sinan Kaya (6):
  vfio: platform: rename reset function
  vfio: platform: move reset call to a common function
  vfio: platform: determine reset capability
  vfio: platform: add support for ACPI probe
  vfio: platform: call _RST method when using ACPI
  vfio, platform: make reset driver a requirement by default

 drivers/vfio/platform/vfio_amba.c             |   5 +
 drivers/vfio/platform/vfio_platform.c         |   5 +
 drivers/vfio/platform/vfio_platform_common.c  | 170 +++++++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |   8 +-
 4 files changed, 153 insertions(+), 35 deletions(-)

-- 
1.8.2.1
