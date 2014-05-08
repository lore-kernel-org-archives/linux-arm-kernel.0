From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 May 2014 19:34:07 +0200
Subject: [PATCH V2 0/4] Exynos4 SoC camera subsystem driver cleanups
Message-ID: <1399570448-29737-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series includes some bug fixes for the Exynos4/S5P SoC camera
interface drivers and removes (ab)use of "simple-bus" compatible string.

Comparing to previous version I've excluded patches dropping support
for non-dt platforms and added two further bug fixes.
of_platform_populate() is used instead of manually parsing the device
tree and creating devices and the cleanup function has been moved to
the core. This series depends on patch:
http://www.kernelhub.org/?msg=466319&p=2

Sylwester Nawrocki (4):
  exynos4-is: Free FIMC-IS CPU memory only when allocated
  exynos4-is: Move firmware request to subdev open()
  exynos4-is: Remove requirement for "simple-bus" compatible
  ARM: dts: exynos4: Remove simple-bus compatibles from the camera
    subsystem

 .../devicetree/bindings/media/samsung-fimc.txt     |    6 +--
 arch/arm/boot/dts/exynos4.dtsi                     |    2 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |    2 +-
 drivers/media/platform/exynos4-is/fimc-is.c        |   50 ++++++++++----------
 drivers/media/platform/exynos4-is/fimc-is.h        |    2 +-
 drivers/media/platform/exynos4-is/fimc-isp.c       |   10 +++-
 drivers/media/platform/exynos4-is/media-dev.c      |   21 ++++++--
 7 files changed, 58 insertions(+), 35 deletions(-)

--
1.7.9.5
