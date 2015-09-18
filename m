From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Fri, 18 Sep 2015 16:20:56 +0200
Subject: [PATCH 0/4] Exynos 5433 jpeg h/w codec support
Message-ID: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for Exynos 5433 to the s5p-jpeg driver.

The series also includes jpeg codec node definition for Device Tree,
but it depends on:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
branch v4.3-drop/dt64-samsung which has not made it into 4.3,
but the driver is meant for 4.4.

Rebased onto Mauro's master with the branch mentioned above merged.

This patch series also adds Andrzej Pietrasiewicz and
Jacek Anaszewski as maintainers of drivers/media/platform/s5p-jpeg.

Andrzej is the original author of the driver, and has committed
support for three Exynos chip models and some fixes.
Jacek has committed support for another three and a number of fixes,
and is the second author of the driver.
The code size is now quite large compared to the initial release,
so having it maintained is a good idea and we both have the supported
hardware at hand.

Andrzej Pietrasiewicz (2):
  s5p-jpeg: add support for 5433
  MAINTAINERS: add exynos jpeg codec maintainers

Marek Szyprowski (2):
  s5p-jpeg: generalize clocks handling
  ARM64: dts: exynos5433: add jpeg node

 .../bindings/media/exynos-jpeg-codec.txt           |   3 +-
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  21 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c        | 444 ++++++++++++++++++---
 drivers/media/platform/s5p-jpeg/jpeg-core.h        |  41 +-
 drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c  |  80 +++-
 drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h  |  11 +-
 drivers/media/platform/s5p-jpeg/jpeg-regs.h        |  85 ++--
 8 files changed, 588 insertions(+), 105 deletions(-)

-- 
1.9.1
