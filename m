From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Fri, 21 Sep 2012 18:29:54 +0530
Subject: [PATCH V2 0/3] Add device tree based discovery support for drm-fimd
Message-ID: <1348232397-2477-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds arch side support for device tree based discovery
for drm-fimd.

The patches are created against "for-next" branch of Kukjin Kim's tree on 3.6-rc6 at:
 git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

This patchset has been tested on smdk5250 board and seen the bootup logo on LCD
using the patchset http://www.spinics.net/lists/arm-kernel/msg193348.html which was 
applied on inki-dae's next branch

Changes since V1:
	- Renamed the compatible string from "samsung,exynos5-drm" to "samsung,exynos5-fimd"
	- Renamed the macro from EXYNOS5_PA_FIMD to EXYNOS5_PA_FIMD1

Leela Krishna Amudala (3):
  ARM: EXYNOS5: Add fimd node to the exynos5250 dtsi file
  ARM: EXYNOS: add device tree based discovery support for FIMD
  ARM: EXYNOS: Add drm-device node to the dtsi file

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   11 +++++++++++
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    2 ++
 4 files changed, 29 insertions(+), 0 deletions(-)
