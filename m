From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 06 Jun 2015 03:04:59 +0900
Subject: [GIT PULL 3/5] Samsung DT updates for v4.2
Message-ID: <5571E4CB.3070302@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-3

for you to fetch changes up to 5ec1d441a4227b2dfdc47fdc13aa7c6c50496194:

  ARM: dts: Add syscon property to the MIPI DPHY for exynos4415
(2015-06-03 09:47:05 +0900)

----------------------------------------------------------------
Samsung DT updates for v4.2

- for exyos3250
  : use s3c6410-rtc instead of exynos3250-rtc
  : add JPEG codec node and support it on exynos3250-rinato
  : use s3c-rtc clock id for exynos3250-rinato and monk boards

- for exynos4
  : add JPEG codec node and syscon property to MIPI DPHY
  : remove obsolete MIPI DPHY reg property
  : enable s3c-rtc on exynos4412-trats2

- for exynos5
  : add syscon property to MIPI DPHY for exynos5420
  : enable s3c-rtc on exynos5420-arndale-octa
  : add missing irq pinctrl for max77686 on exynos5250-smdk5250

  : clk: add bindings for 32kHz clocks from s2mps11
  : fix pinctrl for s2mps11-irq on exynos5420-arndale-octa

- for exynos5422-odroidxu3
  : add mmc detect gpio and LEDs
  : add HS400 support, simple-audio-card and rtc_src clock

----------------------------------------------------------------
Andrzej Hajda (1):
      ARM: dts: add mmc detect gpio for exynos5422-odroidxu3

Inha Song (1):
      ARM: dts: support simple-audio-card for exynos5420 and
exynos5422-odroidxu3

Jacek Anaszewski (2):
      ARM: dts: add JPEG codec device node for exynos3250
      ARM: dts: add support JPEG codec for exynos3250-rinato

Krzysztof Kozlowski (8):
      ARM: dts: fix pinctrl for s2mps11-irq on exynos5420-arndale-octa
      ARM: dts: Use s3c6410-rtc instead of exynos3250-rtc for
exynos3250/4415
      ARM: dts: Use define for s3c-rtc clock id for exynos3250-rinato
      ARM: dts: Use define for s3c-rtc clock id for exynos3250-monk
      ARM: dts: Enable S3C RTC on exynos4412-trats2 and
exynos5420-arndale-octa
      ARM: dts: Use last parent for clocks during power domain on/off
      ARM: dts: Remove obsolete MIPI DPHY 'reg' property for exynos4
      ARM: dts: Add syscon property to the MIPI DPHY for exynos4415

Marek Szyprowski (1):
      ARM: dts: add jpeg-codec node for exynos4 and exynos4x12

Markus Reichl (4):
      ARM: dts: Add LEDs for exynos5422-odroidxu3
      ARM: dts: Add HS400 support for exynos5422-odroidxu3
      clk: samsung: Add bindings for 32kHz clocks from s2mps11
      ARM: dts: add 'rtc_src' clock to rtc node for exynos5422-odroidxu3

Tomeu Vizoso (1):
      ARM: dts: Add syscon property to the MIPI phy in exynos5420

Yadwinder Singh Brar (1):
      ARM: dts: Add missing irq pinctrl for max77686 on smdk5250

 Documentation/devicetree/bindings/rtc/s3c-rtc.txt |  3 +-
 arch/arm/boot/dts/exynos3250-monk.dts             |  3 +-
 arch/arm/boot/dts/exynos3250-rinato.dts           |  7 +-
 arch/arm/boot/dts/exynos3250.dtsi                 | 15 +++-
 arch/arm/boot/dts/exynos4.dtsi                    | 12 ++-
 arch/arm/boot/dts/exynos4412-trats2.dts           |  9 ++-
 arch/arm/boot/dts/exynos4415.dtsi                 |  4 +-
 arch/arm/boot/dts/exynos4x12.dtsi                 |  4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts         | 12 +++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts     | 24 ++++--
 arch/arm/boot/dts/exynos5420.dtsi                 | 24 +++---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts        | 99
++++++++++++++++++++++-
 include/dt-bindings/clock/samsung,s2mps11.h       | 23 ++++++
 13 files changed, 211 insertions(+), 28 deletions(-)
 create mode 100644 include/dt-bindings/clock/samsung,s2mps11.h
