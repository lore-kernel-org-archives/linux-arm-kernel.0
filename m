From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Fri, 17 Apr 2015 22:56:19 +0900
Subject: [PATCH v2 0/7] ARM: dts: exynos5: labels for overriding nodes
Message-ID: <1429278986-4374-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Changes since v1
================
1. Re-phrased the description (phandle->label). Suggested by Arnd.

Description
===========
The label-based notation reduces possible mistakes when overriding
nodes by child DTSI and board files and reduces duplication
of addresses.

The patchset refactors Exynos5 boards to use labels for overriding nodes.

Tested by comparison of decompiled DTB for each commit.


Patchset depends (to reduce conflicts) on following patches:
1. v2: ARM: dts: Enable S3C RTC on Trats2 and Arndale Octa
   http://www.spinics.net/lists/arm-kernel/msg410429.html
2. ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ on Arndale Octa
   http://www.spinics.net/lists/linux-samsung-soc/msg43435.html


Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  ARM: dts: Add labels to Exynos5 nodes
  ARM: dts: exynos5: Use labels for overriding nodes in Exynos5250
  ARM: dts: exynos5: Remove duplicated I2C7 nodes in Snow
  ARM: dts: exynos5: Use labels for overriding nodes in Arndale Octa
  ARM: dts: exynos5: Use labels for overriding nodes in Exynos5420
  ARM: dts: exynos5: Use labels for overriding nodes in SMDK5420
  ARM: dts: exynos5: Use labels for overriding nodes in Exynos5440
    boards

 arch/arm/boot/dts/exynos5.dtsi                |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts         |  46 +-
 arch/arm/boot/dts/exynos5250.dtsi             |  82 ++--
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 634 ++++++++++++-------------
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |   2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts     | 645 +++++++++++++-------------
 arch/arm/boot/dts/exynos5420.dtsi             |  80 ++--
 arch/arm/boot/dts/exynos5440-sd5v1.dts        |  10 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts     |  85 ++--
 arch/arm/boot/dts/exynos5440.dtsi             |   4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   2 +-
 11 files changed, 797 insertions(+), 799 deletions(-)

-- 
2.1.0
