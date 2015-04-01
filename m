From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 02 Apr 2015 03:16:38 +0900
Subject: [GIT PULL 3/5] Samsung DT updates for v4.1
Message-ID: <551C3606.9070103@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt

for you to fetch changes up to f27b907595fc586bce62b8a3dc421e89bb927250:

  ARM: dts: Fixed typo interrupt-cells for exynos5420 and exynos5250
(2015-03-27 01:55:28 +0900)

----------------------------------------------------------------
Samsung DT updates for v4.1

- for exynos3250
  : add assigned clock parents for CMU nodes

- for exynos4412-odroid
  : add eMMC reset line

- for exynos5250
  : fixed typo for interrupt-cells

- for exynos5250-snow
  : define stdout-path property
  : represent bridge and panel connection
  : enable wifi power-on and add cap-sdio-irq to wifi mmc node

- for exynos5250-spring
  : define stdout-path property

- for exynos5420
  : fixed typo for interrupt-cells
  : add async-bridge clocks for gsc and disp1 PDs

- for exynos5420 boards
  : Mux XMMCnDATA[0] pad correctly

- for exynos5420-odroidxu3
  : add eMMC reset line

- for Peach boards
  : add HS400 support and define stdout-path property
  : add mclk entry and add WiFi module support
  : represent bridge and panel connection

----------------------------------------------------------------
Ajay Kumar (2):
      ARM: dts: represent bridge and panel connection for exynos5250-snow
      ARM: dts: represent bridge and panel connection for
exynos5420-peach-pit

Anand Moon (1):
      ARM: dts: Fixed typo interrupt-cells for exynos5420 and exynos5250

Andrzej Hajda (3):
      dt-bindings: add asynchronous bridge clock for exynos
      ARM: dts: add async-bridge clocks to disp1 power domain for exynos5420
      ARM: dts: add async-bridge clocks to gsc power domain for exynos5420

Beata Michalska (1):
      ARM: dts: Add assigned clock parents to CMU node for exynos3250

Javier Martinez Canillas (7):
      ARM: dts: Enable wifi power-on for exynos5250-snow
      ARM: dts: Add cap-sdio-irq to wifi mmc node for exynos5250-snow
      ARM: dts: Mux XMMCnDATA[0] pad correctly for Exynos5420 boards
      ARM: dts: Add WiFi module support for Peach boards
      ARM: dts: Define stdout-path property for Peach boards
      ARM: dts: Define stdout-path property for exynos5250-snow
      ARM: dts: Define stdout-path property for exynos5250-spring

Marek Szyprowski (2):
      ARM: dts: add eMMC reset line for exynos4412-odroid-common
      ARM: dts: add eMMC reset line for exynos5422-odroidxu3

Seungwon Jeon (1):
      ARM: dts: Add HS400 support for exynos5420 and exynos5800

Tushar Behera (1):
      ARM: dts: Add mclk entry for Peach boards

 .../bindings/arm/exynos/power_domain.txt           |  3 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  4 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 14 +++
 arch/arm/boot/dts/exynos5250-snow.dts              | 57 ++++++++++++-
 arch/arm/boot/dts/exynos5250-spring.dts            |  1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  4 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 99
+++++++++++++++++++++-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  7 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  7 +-
 arch/arm/boot/dts/exynos5420.dtsi                  | 10 ++-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 21 ++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 71 +++++++++++++++-
 13 files changed, 280 insertions(+), 20 deletions(-)
