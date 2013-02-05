From: seanpaul@chromium.org (Sean Paul)
Date: Tue,  5 Feb 2013 15:42:55 -0800
Subject: [PATCH v3 0/2] Get the HDMI IP block version from device tree
Message-ID: <1360107777-17490-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set changes the hdmi device tree node to properly represent the version of
the IP block. The first patch changes the drm hdmi driver to use the compatible
field to determine which registers/functions to call, and removes the
unfortunate v1.3/v1.4 naming convention. The second patch updates the arch-
specific bits for exynos5.

Changes in v3:
 - Use compatible field in device tree instead of hdmi-version field
 - Change hdmi driver's naming to use IP version instead of hdmi version


Sean Paul (2):
  drm/exynos: Get HDMI version from device tree
  ARM: Change exynos5-hdmi references to exynos4-hdmi

 .../devicetree/bindings/drm/exynos/hdmi.txt        |    9 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    3 +-
 arch/arm/mach-exynos/clock-exynos5.c               |    4 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  354 ++++++++++----------
 drivers/gpu/drm/exynos/regs-hdmi.h                 |   78 +++---
 6 files changed, 229 insertions(+), 223 deletions(-)

-- 
1.7.7.3
