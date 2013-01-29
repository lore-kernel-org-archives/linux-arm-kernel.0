From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 29 Jan 2013 10:03:54 -0800
Subject: [GIT PULL] Samsung fixes-4 for v3.8
Message-ID: <06c601cdfe4b$01ef8890$05ce99b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here is a pull request for Samsung fixes-4 for v3.8.

This fixes compatible values for exynos pinctrl and crash on soft reset,
tick and alarm irq numbers on exynos5440 and uninitialized variable on
s3c24xx.

If any problems, please kindly let me know.

Thanks.

- Kukjin

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.8-samsung-fixes-4

for you to fetch changes up to 60db7e5f9c9a25a7a9b01007e6e3f5a93bc16a3a:

  ARM: EXYNOS: Fix crash on soft reset on EXYNOS5440 (2013-01-28 14:27:50
-0800)

----------------------------------------------------------------
Cong Ding (1):
      ARM: S3C24XX: fix uninitialized variable warning

Giridhar Maruthy (1):
      ARM: dts: fix tick and alarm irq numbers for exynos5440

Kukjin Kim (1):
      ARM: dts: fix compatible value for exynos pinctrl

Thomas Abraham (2):
      ARM: dts: Fix compatible value of pinctrl module on EXYNOS5440
      ARM: EXYNOS: Fix crash on soft reset on EXYNOS5440

 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt |   12
++++++------
 arch/arm/boot/dts/exynos4210.dtsi                             |    6 +++---
 arch/arm/boot/dts/exynos4x12.dtsi                             |    8
++++----
 arch/arm/boot/dts/exynos5440.dtsi                             |    4 ++--
 arch/arm/mach-exynos/common.c                                 |   10
++++++----
 arch/arm/mach-s3c24xx/common.c                                |    2 +-
 drivers/gpio/gpio-samsung.c                                   |    6 +++---
 drivers/pinctrl/pinctrl-samsung.c                             |    4 ++--
 8 files changed, 27 insertions(+), 25 deletions(-)
