From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Wed, 18 Jul 2012 11:27:26 +0530
Subject: [PATCH V2 0/7] Add device tree based discovery support for drm-fimd
Message-ID: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are created against "for-next" branch of Kukjin Kim's tree at:
 git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

This patch set adds Backlight, LCD support and device tree based discovery
support for drm-fimd.

This patchset has been tested on smdk5250 board and seen the bootup logo on LCD.

The documentation for bindings has been posted to mainline. Please refer to the
link http://www.spinics.net/lists/dri-devel/msg24862.html 

Changes since V1:
	- Removed unwanted empty lines for below patches
  	ARM: EXYNOS5: add machine specific support for backlight
  	ARM: EXYNOS5: add machine specific support for LCD
  	ARM: EXYNOS5: Set parent clock to fimd

Leela Krishna Amudala (7):
  ARM: SAMSUNG: add additional registers and SFR definitions for
    writeback
  ARM: EXYNOS5: add machine specific support for backlight
  ARM: EXYNOS5: add machine specific support for LCD
  ARM: EXYNOS: Adding DRM platform device
  ARM: EXYNOS: add device tree based discovery support for FIMD
  ARM: EXYNOS5: Add the bus clock for FIMD
  ARM: EXYNOS5: Set parent clock to fimd

 arch/arm/boot/dts/exynos5250-smdk5250.dts       |   16 +++
 arch/arm/boot/dts/exynos5250.dtsi               |    7 ++
 arch/arm/mach-exynos/Kconfig                    |    1 +
 arch/arm/mach-exynos/clock-exynos5.c            |   30 ++++--
 arch/arm/mach-exynos/include/mach/map.h         |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c          |  123 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/clock.h      |    2 +
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |   10 ++
 arch/arm/plat-samsung/include/plat/regs-fb.h    |   51 ++++++++++
 drivers/video/Kconfig                           |    6 +
 10 files changed, 237 insertions(+), 10 deletions(-)
