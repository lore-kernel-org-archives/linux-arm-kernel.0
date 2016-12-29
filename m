From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 29 Dec 2016 14:36:49 +0100
Subject: [PATCH 0/2] ARM: add Exynos4412 Prime SoC support
References: <CGME20161229133722epcas5p1e138af585fea93a42962f3a7414a081f@epcas5p1.samsung.com>
Message-ID: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for Exynos4412 Prime SoC (it supports
additional 1704MHz & 1600MHz CPU OPPs and 1500MHz CPU OPP is just
a regular non-turbo OPP on this SoC).

ODROID-X2/U2/U3 boards use Exynos4412 Prime SoC version so their
board files are updated accordingly.

This patchset brings 21% CPU performance increase on affected
boards (as tested on ODROID-U3 board).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (2):
  clk: samsung: exynos4412: add cpu clock configuration data for
    Exynos4412 Prime
  ARM: dts: Add CPU OPPs for Exynos4412 Prime

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
 arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
 arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
 drivers/clk/samsung/clk-exynos4.c               |  4 +++
 6 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi

-- 
1.9.1
