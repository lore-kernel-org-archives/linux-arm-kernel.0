From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 15 Mar 2015 23:00:29 +0100
Subject: [PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
Message-ID: <1426456834-6308-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds a dedicated ODROID-XU device tree and enhances it with 
LED configuration, to match the downstream 3.14 based behavior.

Regards,
Andreas

v3 -> v4:
* Rebased pinctrl (.label field dropped, const'ified, __initconst)
* Edited dts subjects to match Kukjin's preferred style

v2 -> v3:
* Actually rebased pinctrl (.svc, .{g,w}eint_{con,mask,pend} fields dropped)
* Added wake-up IRQ controller node (Tomasz Figa)

v1 -> v2:
* Inserted needed Sobs from Hakjoo Kim

Andreas F?rber (3):
  ARM: dts: Clean up exynos5410-smdk5410 indentation
  ARM: dts: Prepare exynos5410-odroidxu device tree
  ARM: dts: Add LEDs to exynos5410-odroidxu

Hakjoo Kim (2):
  pinctrl: exynos: add exynos5410 SoC specific data
  ARM: dts: add pinctrl support to Exynos5410

 .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 103 ++++++
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 406 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   6 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |  36 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 103 ++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   1 +
 9 files changed, 656 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-odroidxu.dts
 create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi

-- 
2.3.1
