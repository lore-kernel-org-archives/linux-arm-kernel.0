From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon,  6 Apr 2015 22:28:11 +0200
Subject: [PATCH 00/11] ARM: dts: Refactor Exynos4 boards for phandle notation
Message-ID: <1428352102-12855-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The phandle notation reduces possible mistakes when overriding nodes
by child board files and reduces duplication of addresses.

The patchset refactors Exynos4 boards to use the phandle way.

Tested by comparison of decompiled DTB for each commit.

The same refactoring for Exynos5 is on the way.


Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  ARM: dts: Add labels to nodes used in Exynos4 based DTS
  ARM: dts: Use phandle notation for overriding nodes in Exynos4210
  ARM: dts: Use phandle notation for overriding nodes in Exynos4210
    Origen
  ARM: dts: Use phandle notation for overriding nodes in SMDKv310
  ARM: dts: Use phandle notation for overriding nodes in Trats
  ARM: dts: Use phandle notation for overriding nodes in Exynos4212
  ARM: dts: Use phandle notation for overriding nodes in Exynos4x12
  ARM: dts: Use phandle notation for overriding nodes in Exynos4412
  ARM: dts: Use phandle notation for overriding nodes in Odroid
  ARM: dts: Use phandle notation for overriding nodes in SMDK4412
  ARM: dts: Use phandle notation for overriding nodes in Trats2

 arch/arm/boot/dts/exynos4.dtsi                  |   22 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |  418 +++----
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi       |    6 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |  280 ++---
 arch/arm/boot/dts/exynos4210-trats.dts          |  592 +++++-----
 arch/arm/boot/dts/exynos4210.dtsi               |   49 +-
 arch/arm/boot/dts/exynos4212.dtsi               |   12 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  728 ++++++-------
 arch/arm/boot/dts/exynos4412-odroidx.dts        |   16 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |  210 ++--
 arch/arm/boot/dts/exynos4412-trats2.dts         | 1331 ++++++++++++-----------
 arch/arm/boot/dts/exynos4412.dtsi               |   20 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi       |    8 +-
 arch/arm/boot/dts/exynos4x12.dtsi               |  212 ++--
 14 files changed, 1952 insertions(+), 1952 deletions(-)

-- 
2.1.0
