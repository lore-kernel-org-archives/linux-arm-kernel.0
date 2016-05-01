From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun,  1 May 2016 17:07:50 -0400
Subject: [PATCH V4 0/2] vfio, platform: add ACPI support
Message-ID: <1462136872-17590-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset makes three different changes.
1. Add support for probing ACPI platform devices.
2. Add support for ACPI _RST method support during reset
3. Make reset driver a requirement by default with an optional
   kernel command line override

Sinan Kaya (2):
  vfio, platform: add support for ACPI during probe and reset
  vfio, platform: make reset driver a requirement by default

 drivers/vfio/platform/vfio_amba.c             |   5 +
 drivers/vfio/platform/vfio_platform.c         |   5 +
 drivers/vfio/platform/vfio_platform_common.c  | 184 +++++++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |   8 +-
 4 files changed, 165 insertions(+), 37 deletions(-)

-- 
1.8.2.1
