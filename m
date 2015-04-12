From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 12 Apr 2015 21:24:47 +0900
Subject: [PATCH 0/7] ARM: dts: Refactor Exynos5 boards for phandle notation
Message-ID: <1428841494-20769-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The phandle notation reduces possible mistakes when overriding nodes
by child board files and reduces duplication of addresses.

The patchset refactors Exynos5 boards to use the phandle way.

Tested by comparison of decompiled DTB for each commit.


Patchset depends (to reduce conflicts) on following patches:
1. v2: ARM: dts: Enable S3C RTC on Trats2 and Arndale Octa
   http://www.spinics.net/lists/arm-kernel/msg410429.html
2. ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ on Arndale Octa
   http://www.spinics.net/lists/linux-samsung-soc/msg43435.html


Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  ARM: dts: Add labels to nodes used in Exynos5 based DTS
  ARM: dts: Use phandle notation for overriding nodes in Exynos5250
  ARM: dts: Remove duplicated I2C 7 nodes in Snow
  ARM: dts: Use phandle notation for overriding nodes in Arndale Octa
  ARM: dts: Use phandle notation for overriding nodes in Exynos5420
  ARM: dts: Use phandle notation for overriding nodes in SMDK5420
  ARM: dts: Use phandle notation for overriding nodes in Exynos5440
    boards

 arch/arm/boot/dts/exynos5.dtsi                |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts         |  46 +-
 arch/arm/boot/dts/exynos5250.dtsi             |  82 ++--
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 634 ++++++++++++-------------
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |   2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts     | 639 +++++++++++++-------------
 arch/arm/boot/dts/exynos5420.dtsi             |  80 ++--
 arch/arm/boot/dts/exynos5440-sd5v1.dts        |  10 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts     |  85 ++--
 arch/arm/boot/dts/exynos5440.dtsi             |   4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   2 +-
 11 files changed, 794 insertions(+), 796 deletions(-)

-- 
2.1.0
