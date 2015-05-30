From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 30 May 2015 14:25:21 +0900
Subject: [GIT PULL] ARM: EXYNOS: DTS improvements for 4.2, 3rd
Message-ID: <1432963521-20026-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Quite big set of changes, mostly refactor.

You can find them also on the lists with my reviewed-by.

Best regards,
Krzysztof


The following changes since commit 5c78bc1b466701c1b13d7b734f5b39cdd65babab:

  Merge branch 'samsung-defconfig-2nd' into for-next (2015-05-23 12:28:59 +0900)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-dt-for-4.2-3

for you to fetch changes up to a33a220172cd832fd4b9f8c26f4e6053899d68c4:

  ARM: dts: Add Odroid XU3 Lite support (2015-05-30 13:22:45 +0900)

----------------------------------------------------------------
Device Tree improvements for Exynos based boards:
1. Refactor DT sources to label notation. All new Exynos boards follow
   this convention so only old DTS are changed: Exynos4 family, Exynos5
   and s3c2416.
   This convention reduces duplication of addresses in nodes
   and reduces possible mistakes when overriding nodes.
2. Switch LEDs on Odroid XU3 to PWM control.
3. Add nodes for JPEG codec on Exynos542x.
4. Enable wake alarm on Odroid XU3.
5. Add support for new board: Odroid XU3 Lite. The board is actually
   very similar to existing Odroid XU3.

----------------------------------------------------------------
Andrzej Pietrasiewicz (1):
      ARM: dts: exynos5420: add nodes for jpeg codec

Krzysztof Kozlowski (26):
      ARM: dts: Add labels to exynos4 nodes
      ARM: dts: Use labels for overriding nodes in exynos4210
      ARM: dts: Use labels for overriding nodes in exynos4210-origen
      ARM: dts: Use labels for overriding nodes in exynos4210-smdkv310
      ARM: dts: Use labels for overriding nodes in exynos4210-trats
      ARM: dts: Use labels for overriding nodes in exynos4212
      ARM: dts: Use labels for overriding nodes in exynos4x12
      ARM: dts: Use labels for overriding nodes in exynos4412
      ARM: dts: Use labels for overriding nodes in exynos4412-odroid
      ARM: dts: Use labels for overriding nodes in exynos4412-smdk4412
      ARM: dts: Use labels for overriding nodes in exynos4412-trats2
      ARM: dts: Use labels for overriding nodes in exynos4412-origen
      ARM: dts: Use labels for overriding nodes in exynos4412-tiny4412
      ARM: dts: Add labels to exynos5 nodes
      ARM: dts: Use labels for overriding nodes in exynos5250
      ARM: dts: Remove duplicated I2C7 nodes in exynos5250-snow
      ARM: dts: Use labels for overriding nodes in exynos5420-arndale-octa
      ARM: dts: Use labels for overriding nodes in exynos542x
      ARM: dts: Use labels for overriding nodes in exynos5420-smdk5420
      ARM: dts: Use labels for overriding nodes in exynos5440 boards
      ARM: dts: Use labels for overriding nodes in exynos5422-odroidxu3
      ARM: dts: s3c2416: Add labels to S3C2416 nodes
      ARM: dts: s3c2416: Use labels for overriding nodes in SMDK2416
      ARM: dts: odroidxu3: Enable wake alarm of S2MPS11 RTC
      of: Add vendor prefix for Hardkernel
      ARM: dts: Add Odroid XU3 Lite support

Peter Chubb (1):
      ARM: dts: exynos5422-odroidxu3: Hook up PWM and use it for LEDs

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   22 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |  418 +++---
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  280 ++--
 arch/arm/boot/dts/exynos4210-trats.dts             |  592 ++++-----
 arch/arm/boot/dts/exynos4210.dtsi                  |   49 +-
 arch/arm/boot/dts/exynos4212.dtsi                  |   12 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  732 +++++------
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   16 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  892 ++++++-------
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  210 +--
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |   54 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            | 1332 ++++++++++----------
 arch/arm/boot/dts/exynos4412.dtsi                  |   20 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |    8 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  218 ++--
 arch/arm/boot/dts/exynos5.dtsi                     |    6 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   46 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   82 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  634 +++++-----
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  645 +++++-----
 arch/arm/boot/dts/exynos5420.dtsi                  |   98 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  479 +++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   20 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  430 +------
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |   10 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   85 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    2 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   86 +-
 arch/arm/boot/dts/s3c2416.dtsi                     |   18 +-
 33 files changed, 3796 insertions(+), 3708 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
