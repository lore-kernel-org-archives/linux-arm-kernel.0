From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 12:13:42 +0900
Subject: [GIT PULL] ARM: EXYNOS: dts: Improvements for 4.2, second try
Message-ID: <1431314022-17062-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

I gathered various improvements for upcoming 4.2 merge window.
Description along with a tag.

Best regards,
Krzysztof


The following changes since commit 2495ae559826c60e3ccde9850e3b38815725b9c9:

  ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards (2015-05-11 11:00:00 +0900)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-dt-for-next-4.2-2

for you to fetch changes up to c5f41228c9fad4c7343df8547b870766163b76dc:

  ARM: dts: exynos3250-rinato: add support for JPEG codec (2015-05-11 11:01:57 +0900)

----------------------------------------------------------------
Device Tree improvements for Exynos based boards:
1. Fix PMIC's RTC alarm on Arndale Octa (S2MPS11 PMIC) and SMDK5250 (MAXIM77686
   PMIC).
2. Enable the S3C RTC (the clock present on SoC) on various Exynos boards.
3. Minor improvements to S3C RTC driver.
4. Add nodes for JPEG codec on Exynos4 and enable it for Rinato board.
5. Add audio on Odroid-XU3 board.

----------------------------------------------------------------
Inha Song (1):
      ARM: dts: Support audio on Exynos5422-odroidxu3 using simple-audio-card

Jacek Anaszewski (1):
      ARM: dts: exynos3250-rinato: add support for JPEG codec

Krzysztof Kozlowski (5):
      ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ on Arndale Octa
      ARM: dts: s3c-rtc: Use s3c6410-rtc instead of exynos3250-rtc
      ARM: dts: Use define for s3c-rtc clock id
      ARM: dts: Use define for s3c-rtc clock id
      ARM: dts: Enable S3C RTC on Trats2 and Arndale Octa

Marek Szyprowski (1):
      ARM: dts: exynos4: add nodes for jpeg codec

Markus Reichl (2):
      ARM: dts: Add bindings for 32kHz clocks from s2mps11
      ARM: dts: exynos5422-odroidxu3: add 'rtc_src' clock to rtc node

 Documentation/devicetree/bindings/rtc/s3c-rtc.txt |  3 +-
 arch/arm/boot/dts/exynos3250-monk.dts             |  3 +-
 arch/arm/boot/dts/exynos3250-rinato.dts           |  7 ++-
 arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                    | 11 +++-
 arch/arm/boot/dts/exynos4412-trats2.dts           |  9 ++-
 arch/arm/boot/dts/exynos4415.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos4x12.dtsi                 |  4 ++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts     | 24 ++++++--
 arch/arm/boot/dts/exynos5420.dtsi                 |  9 +++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts        | 70 +++++++++++++++++++++--
 include/dt-bindings/clock/samsung,s2mps11.h       | 23 ++++++++
 12 files changed, 151 insertions(+), 16 deletions(-)
 create mode 100644 include/dt-bindings/clock/samsung,s2mps11.h
