From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 28 Mar 2016 09:35:21 -0400
Subject: [PATCH V3 0/3] vfio, platform: add HIDMA and ACPI support
Message-ID: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset makes three different changes.
1. Add support for probing ACPI platform reset drivers.
2. Make reset driver a requirement by default with an optional kernel
command line override
3. Add support for HIDMA reset driver.

Specific changes:

vfio, platform: make reset driver a requirement
Changes from V2: (https://lkml.org/lkml/2016/3/11/463)
* add reset_required kernel command line option to override the
  requirement.

Sinan Kaya (3):
  vfio, platform: add support for ACPI while detecting the reset driver
  vfio, platform: make reset driver a requirement by default
  vfio, platform: add QTI HIDMA reset driver

 drivers/vfio/platform/reset/Kconfig                |   9 ++
 drivers/vfio/platform/reset/Makefile               |   2 +
 .../vfio/platform/reset/vfio_platform_amdxgbe.c    |   4 +-
 .../platform/reset/vfio_platform_calxedaxgmac.c    |   4 +-
 .../vfio/platform/reset/vfio_platform_qcomhidma.c  | 101 ++++++++++++++++++
 drivers/vfio/platform/vfio_amba.c                  |   5 +
 drivers/vfio/platform/vfio_platform.c              |   5 +
 drivers/vfio/platform/vfio_platform_common.c       | 115 +++++++++++++++++----
 drivers/vfio/platform/vfio_platform_private.h      |  44 ++++----
 9 files changed, 250 insertions(+), 39 deletions(-)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_qcomhidma.c

-- 
1.8.2.1
