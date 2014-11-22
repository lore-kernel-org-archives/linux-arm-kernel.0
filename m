From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 22 Nov 2014 21:26:19 +0100
Subject: [PATCH v2 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
Message-ID: <1416687984-3546-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds a dedicated ODROID-XU device tree and enhances it with 
LED configuration, to match the downstream 3.14 based behavior.

Regards,
Andreas

v1 -> v2:
* Inserted needed Sobs from Hakjoo Kim
* Rebased pinctrl (.svc, .{g,w}eint_{con,mask,pend} fields dropped)

Andreas F?rber (3):
  ARM: dts: exynos5410: Clean up SMDK5410 indentation
  ARM: dts: exynos5410: Prepare ODROID-XU device tree
  ARM: dts: exynos5410: Add ODROID-XU LEDs

Hakjoo Kim (2):
  pinctrl: exynos: add exynos5410 SoC specific data
  ARM: dts: add pinctrl support to Exynos5410

 .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 103 ++++++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 406 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   6 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |  30 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 126 +++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   1 +
 9 files changed, 673 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi

-- 
2.1.2
