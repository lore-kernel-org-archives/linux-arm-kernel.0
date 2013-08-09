From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 09 Aug 2013 16:40:48 +0900
Subject: [PATCHv2 0/5] device tree support for exynos rotator
Message-ID: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes device tree support for rotator of exynos4210/4x12/5250.
Unfortunately, each of them has slightly different limitations of image size.
The rotator can support several image formats(RGB888/555, YCbCr422/420_2/3p).
For convinience, however, exynos drm rotator driver only support RGB888 and
YCbCr420 2-Plane formats. For example, the exynos4210 has 16k x 16k maximum size
. But rest of them has 8k x 8k. In addition, RGB888 X/Y pixel size of exynos5250
should be multiple of 2. But others are multiple of 4.
Thus, we should define different compatibles and limit tables for each chipsets.

Changes from v1:
 - Added exynos5250 binding.
 - Move limit table into driver code from DT-nodes

Chanho Park (5):
  drm/exynos: add device tree support for rotator
  ARM: dts: Add rotator node for exynos4210
  ARM: dts: Add rotator node for exynos4x12
  ARM: dts: Add rotator node for exynos5250
  ARM: dts: Add dt binding documentation for exynos rotator

 .../devicetree/bindings/gpu/samsung-rotator.txt    |   26 +++++
 arch/arm/boot/dts/exynos4.dtsi                     |    9 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |    4 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    9 ++
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |  109 +++++++++++++++-----
 5 files changed, 129 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt

-- 
1.7.9.5
