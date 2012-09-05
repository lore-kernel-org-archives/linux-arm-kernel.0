From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Wed, 05 Sep 2012 21:09:13 +0530
Subject: [PATCH V4 0/2] video: drm: Add Device tree support to DRM-FIMD
Message-ID: <1346859555-13527-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds device tree support for DRM-FIMD for Samsung's Exynos5250.
It includes parsing platform data from dts file. Also, adds the driver data
for exynos4 and exynos5 devices.

This patchset is based and tested on top of v3.6-rc4
Also depends on below patchset
http://lists.freedesktop.org/archives/dri-devel/2012-August/026076.html

Changes since V3:
        - Removed the fimd version from driver data and using timing base
          address instead
        - Removed the drm_ prefixes to the structures and fucntions

Changes since V2:
        - Added driver data to exynos5-drm-fimd as per Marek Szyprowski suggestion

Changes since V1:
        - Corrected typo errors and changed compatibility string

Leela Krishna Amudala (2):
  drm/exynos: add platform_device_id table and driver data for drm fimd
  video: drm: exynos: Add device tree support

 Documentation/devicetree/bindings/fb/drm-fimd.txt |   80 ++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c          |  140 +++++++++++++++++++-
 2 files changed, 213 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/drm-fimd.txt
