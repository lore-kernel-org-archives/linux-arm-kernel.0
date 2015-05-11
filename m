From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 22:42:40 +0900
Subject: [PATCH v4 00/13] ARM: dts: exynos4: labels for overriding nodes
Message-ID: <1431351773-2031-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Changes since v3
================
1. New patches (12 and 13) for Exynos4412 Origen and Tiny4412.
2. Rebased on top of my DTS-for-next branch:
   repo: https://github.com/krzk/linux/
   tag: samsung-dt-for-next-4.2-2

Changes since v2
================
1. Fix typo in commit msg (lablels -> labels).


Changes since v1
================
1. Re-phrased the description (phandle->label). Suggested by Arnd.

Description
===========

The label-based notation reduces possible mistakes when overriding
nodes by child DTSI and board files and reduces duplication
of addresses.

The patchset refactors Exynos4 boards to use labels for overriding nodes.

Tested by comparison of decompiled DTB for each commit. The output DTB
is the same.


Best regards,
Krzysztof


Krzysztof Kozlowski (13):
  ARM: dts: Add labels to Exynos4 nodes
  ARM: dts: exynos4: Use labels for overriding nodes in Exynos4210
  ARM: dts: exynos4: Use labels for overriding nodes in Exynos4210
    Origen
  ARM: dts: exynos4: Use labels for overriding nodes in SMDKv310
  ARM: dts: exynos4: Use labels for overriding nodes in Trats
  ARM: dts: exynos4: Use labels for overriding nodes in Exynos4212
  ARM: dts: exynos4: Use labels for overriding nodes in Exynos4x12
  ARM: dts: exynos4: Use labels for overriding nodes in Exynos4412
  ARM: dts: exynos4: Use labels for overriding nodes in Odroid
  ARM: dts: exynos4: Use labels for overriding nodes in SMDK4412
  ARM: dts: exynos4: Use labels for overriding nodes in Trats2
  ARM: dts: exynos4: Use labels for overriding nodes in Exynos4412
    Origen
  ARM: dts: exynos4: Use labels for overriding nodes in Tiny4412

 arch/arm/boot/dts/exynos4.dtsi                  |   22 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |  418 +++----
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi       |    6 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |  280 ++---
 arch/arm/boot/dts/exynos4210-trats.dts          |  592 +++++-----
 arch/arm/boot/dts/exynos4210.dtsi               |   49 +-
 arch/arm/boot/dts/exynos4212.dtsi               |   12 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  732 ++++++-------
 arch/arm/boot/dts/exynos4412-odroidx.dts        |   16 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |  892 +++++++--------
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |  210 ++--
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   54 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         | 1332 ++++++++++++-----------
 arch/arm/boot/dts/exynos4412.dtsi               |   20 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi       |    8 +-
 arch/arm/boot/dts/exynos4x12.dtsi               |  218 ++--
 16 files changed, 2431 insertions(+), 2430 deletions(-)

-- 
2.1.4
