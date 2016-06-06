From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:30 +0200
Subject: [GIT PULL 5/8] ARM: dts: exynos: DTS for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.8

for you to fetch changes up to cb0df00040d593e3f56eaafdede568121f962c06:

  ARM: dts: exynos: No need to enable TMU nodes on Odroid XU3 family (2016-06-06 13:21:39 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.8:
1. Add missing async bridge for MFC power domain on Exynos5420.
   This fixes imprecise abort on s5p-mfc re-bind.
2. Define regulator supplies for MMC nodes on Exynos4412 Odroid boards
   and for TMU on Exynos542x Peach boards.
3. Thermal cleanups on Odroid XU3-family (Exynos5422).
4. Enable AX88760 USB hub on Origen board (Exynos4412).
5. Minor cleanups.

----------------------------------------------------------------
Javier Martinez Canillas (3):
      ARM: dts: exynos: Add async-bridge clock to MFC power domain for Exynos5420
      ARM: dts: exynos: Remove unneded always-on for regulators on Peach boards
      ARM: dts: exynos: Add TMU nodes regulator supply for Peach boards

Krzysztof Kozlowski (5):
      ARM: dts: exynos: Define vqmmc for SD card and allow disabling regulators on Odroid X/X2/U3
      ARM: dts: exynos: Define vqmmc for eMMC card on Odroid X/X2/U3
      ARM: dts: exynos: Lower SD card interface voltage to 2.8 V on Odroid X/X2/U3
      ARM: dts: exynos: Only Odroid XU3-family boards use DTSI with CPU thermal nodes
      ARM: dts: exynos: No need to enable TMU nodes on Odroid XU3 family

Matthew Leach (1):
      ARM: dts: exynos: Enable AX88760 USB hub on Origen board

Naveen Krishna Chatradhi (1):
      ARM: dts: exynos: Use new compatible string for thermistors in Trats2

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  28 ++++--
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  18 ++++
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  11 +++
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |  11 +++
 arch/arm/boot/dts/exynos4412-origen.dts            |  16 ++++
 arch/arm/boot/dts/exynos4412-trats2.dts            |   4 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  26 ++++--
 arch/arm/boot/dts/exynos5420.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi      | 103 ---------------------
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  98 ++++++++++++++++++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  26 ++++--
 11 files changed, 211 insertions(+), 135 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
