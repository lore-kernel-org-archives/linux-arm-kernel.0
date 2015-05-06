From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 May 2015 09:59:41 +0900
Subject: ARM: EXYNOS: dts: Improvements for 4.2
Message-ID: <1430873981-22902-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

I gathered various improvements for upcoming 4.2 merge window.
Description along with a tag.

Best regards,
Krzysztof

----------------------------------------------------------------
The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-dt-for-next-4.2

for you to fetch changes up to 98155ec454a40212434c83c1388c420a61d62854:

  ARM: dts: exynos4: add nodes for jpeg codec (2015-05-05 19:19:18 +0900)

----------------------------------------------------------------
Device Tree improvements for Exynos based boards:
1. Fix PMIC's RTC alarm on Arndale Octa (S2MPS11 PMIC) and SMDK5250 (MAXIM77686
   PMIC).
2. Fix suspend on Peach Pit Chromebooks prevented by Marvell mwifiex
   driver.
3. Fix hang on Odroid XU3 on MMC card detect.
4. Enable the S3C RTC (the clock present on SoC) on various Exynos boards.
5. Minor improvements to S3C RTC driver.
6. Add nodes for JPEG codec on Exynos4.

----------------------------------------------------------------
Andrzej Hajda (1):
      ARM: dts: exynos5422-odroidxu3: add mmc detect gpio

Javier Martinez Canillas (2):
      ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420
      ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards

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

Yadwinder Singh Brar (1):
      ARM: dts: Add missing irq pinctrl for max77686 on smdk5250

 Documentation/devicetree/bindings/rtc/s3c-rtc.txt |  3 ++-
 arch/arm/boot/dts/exynos3250-monk.dts             |  3 ++-
 arch/arm/boot/dts/exynos3250-rinato.dts           |  3 ++-
 arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                    | 11 ++++++++++-
 arch/arm/boot/dts/exynos4412-trats2.dts           |  9 ++++++++-
 arch/arm/boot/dts/exynos4415.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos4x12.dtsi                 |  4 ++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts         | 12 ++++++++++++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts     | 24 ++++++++++++++++++-----
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |  1 +
 arch/arm/boot/dts/exynos5420.dtsi                 |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts        | 16 +++++++++------
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |  1 +
 include/dt-bindings/clock/samsung,s2mps11.h       | 23 ++++++++++++++++++++++
 15 files changed, 97 insertions(+), 18 deletions(-)
 create mode 100644 include/dt-bindings/clock/samsung,s2mps11.h
