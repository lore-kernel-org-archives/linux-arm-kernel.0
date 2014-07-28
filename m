From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Jul 2014 14:18:07 +0200
Subject: [RFC 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
Message-ID: <1406549892-5558-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds a dedicated ODROID-XU device tree and enhances it with 
LED configuration, to match the downstream 3.14 based behavior.

It had turned out less trivial than I initially thought as the whole 
pinctrl stuff is still missing. I thus cherry-pick two downstream commits.

Hakjoo, can you please reply with a Signed-off-by to your patches
so that we can get them into upstream? Thanks in advance!

Regards,
Andreas

Cc: Hakjoo Kim <ruppi.kim@hardkernel.com>

Andreas F?rber (3):
  ARM: dts: exynos5410: Clean up SMDK5410 indentation
  ARM: dts: exynos5410: Prepare ODROID-XU device tree
  ARM: dts: exynos5410: Add ODROID-XU LEDs

Hakjoo Kim (2):
  pinctrl: exynos: add exynos5410 SoC specific data
  ARM: dts: add pinctrl support to Exynos5410

 .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 111 ++++++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 408 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   6 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |  32 ++
 drivers/pinctrl/pinctrl-exynos.c                   | 126 +++++++
 drivers/pinctrl/pinctrl-samsung.c                  |   2 +
 drivers/pinctrl/pinctrl-samsung.h                  |   1 +
 9 files changed, 685 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi

-- 
1.9.3
