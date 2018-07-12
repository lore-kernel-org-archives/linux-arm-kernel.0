From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 12 Jul 2018 18:46:40 +0200
Subject: [GIT PULL 1/3] ARM: dts: exynos: Pull for v4.19
In-Reply-To: <20180712164641.19925-1-krzk@kernel.org>
References: <20180712164641.19925-1-krzk@kernel.org>
Message-ID: <20180712164641.19925-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rebased on v4.18-rc2.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.19

for you to fetch changes up to 57f4e8bc1c3ebbd06a278107edeb6af95b53e5bf:

  dt-bindings: samsung: Document bindings for SGH-T959P board (2018-07-07 12:28:07 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.19

1. Add two new S5Pv210 boards: Samsung Galaxy S and Samsung Galaxy S 4G
   mobile phones.? Both are from family codenamed Aries.? The Samsung
   Galaxy S was released on the market in 2010 with Android operating
   system.? At that time, it was the Samsung's flagship model.
? ?This brings support for storage (SD card and internal memory), PMIC,
   RTC, fuel-gauge, keys, USB (in peripherial mode) and WiFi.

2. Add missing secondary CPU properties.
3. Cleanup from old files and properties.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: dts: exynos: remove no longer needed samsung thermal properties

Jonathan Bakker (2):
      ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
      dt-bindings: samsung: Document bindings for SGH-T959P board

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Add missing CPU clocks to secondary CPUs on Exynos542x
      dt-bindings: arm: Remove obsolete insignal-boards.txt

Pawe? Chmiel (4):
      ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
      ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
      ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
      dt-bindings: samsung: Document bindings for Samsung aries boards

Viresh Kumar (1):
      arm: dts: exynos: Add missing cooling device properties for CPUs

 .../devicetree/bindings/arm/insignal-boards.txt    |   8 -
 .../bindings/arm/samsung/samsung-boards.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  18 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  13 +
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  20 -
 arch/arm/boot/dts/exynos4412.dtsi                  |   9 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  25 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   6 +
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  21 --
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   8 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 419 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  45 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  77 ++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |   2 +
 18 files changed, 635 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
