From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 13 Sep 2017 20:41:51 +0900
Subject: [PATCH v4 0/4] Exynos-gsc: Support the hardware rotation limits
References: <CGME20170913114214epcas2p11a7b99e0c69236a87506e3c5db4858fa@epcas2p1.samsung.com>
Message-ID: <1505302915-15699-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Frist, thanks Krzysztof, Robin and Sylwester.

The gscaler has hardware rotation limits. So this patch set support
the rotate hardware limits of gsc.

Changes for V4:
- Fixed the most specific compatible come first in device tree.
- Kept compatible("samsung,exynos5-gsc") in ther driver.
- Added mark compatible("samsung,exynos5-gsc") as deprecated.
- Added print dmesg if your driver uses compatible("samsung, exynos5-gsc").
- Removed the patch 5, 6 of ver3.

Changes for V3:
- Fixed of_match_node() to of_device_get_match_data() in drm gsc driver.
- Added hardware rotation limits for gsc driver of v4l2.
- Added the remove unnecessary compatible for DT document and Exynos dts.

Changes for V2:
- Added the interface info in binding document.
- Added clean name of compatible in Exynos dts.
- Added maximum supported picture size hardcoded into driver.

Best regards,
Hoegeun

Hoegeun Kwon (4):
  [media] exynos-gsc: Add compatible for Exynos 5250 and 5420 specific
    version
  ARM: dts: exynos: Add clean name of compatible.
  drm/exynos/gsc: Add hardware rotation limits
  [media] exynos-gsc: Add hardware rotation limits

 .../devicetree/bindings/media/exynos5-gsc.txt      |   9 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            | 104 ++++++++++++-----
 drivers/media/platform/exynos-gsc/gsc-core.c       | 127 ++++++++++++++++++++-
 include/uapi/drm/exynos_drm.h                      |   2 +
 6 files changed, 211 insertions(+), 43 deletions(-)

-- 
1.9.1
