From: kgene@kernel.org (Kukjin Kim)
Date: Sun, 10 May 2015 23:47:30 +0900
Subject: [GIT PULL] Samsung fixes for v4.1
Message-ID: <554F6F82.1050904@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is Samsung fixes for v4.1. Since I've missed to send this via
arm-soc tree before v4.1-rc3, so I'm sending this to you directly.

Please pull this. If any problems, please kindly let me know.

Thanks,
Kukjin


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes-1

for you to fetch changes up to 8cf5e6dc8dd55d0f1ad46ab4046c3a8a51d2136d:

  ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for
exynos5250-snow (2015-05-09 03:15:16 +0900)

----------------------------------------------------------------
Samsung fixes for v4.1

- fixes commit ea08de16eb1b ("ARM: dts: Add DISP1 power
  domain for exynos5420") which causes 'unhandled fault:
  imprecise external abort' error when PD turned off.
  : make DP a consumer of DISP1 power domain

- fixes 's3c-rtc' probe failure on Odriod-X2/U2/U3 boards.
  : add 'rtc_src' clock to rtc node for source clock of rtc

- fixes typo for 'cpu-crit-0' trip point on exynos5420/5440

- fixes S2R failure on exynos5250-snow due to card power of
  Marvell WiFi driver (suspend/resume)
  : add keep-power-in-susped to WiFi SDIO node

----------------------------------------------------------------
Abhilash Kesavan (1):
      ARM: dts: Fix typo in trip point temperature for exynos5420/5440

Javier Martinez Canillas (2):
      ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420
      ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for
exynos5250-snow

Markus Reichl (1):
      ARM: dts: add 'rtc_src' clock to rtc node for exynos4412-odroid boards

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 3 +++
 arch/arm/boot/dts/exynos5250-snow.dts           | 1 +
 arch/arm/boot/dts/exynos5420-trip-points.dtsi   | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi               | 1 +
 arch/arm/boot/dts/exynos5440-trip-points.dtsi   | 2 +-
 5 files changed, 7 insertions(+), 2 deletions(-)
