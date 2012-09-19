From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:18:46 +0900
Subject: [GIT PULL 3/7] Samsung pinctrl for v3.7
Message-ID: <099a01cd96bd$1e0baf40$5a230dc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This branch is for supporting pinctrl for Samsung EXYNOS. Now this can
support EXYNOS4210 and other EXYNOS SoCs such as EXYNOS4X12 will be
supported next time.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/pinctrl-samsung

Thomas Abraham (6):
      pinctrl: add samsung pinctrl and gpiolib driver
      pinctrl: add exynos4210 specific extensions for samsung pinctrl driver
      gpio: exynos4: skip gpiolib registration if pinctrl driver is used
      ARM: EXYNOS: skip wakeup interrupt setup if pinctrl driver is used
      ARM: dts: Add pinctrl node entries for SAMSUNG EXYNOS4210 SoC
      ARM: EXYNOS: Enable pinctrl driver support for EXYNOS4 device tree
enabled platform

 .../bindings/pinctrl/samsung-pinctrl.txt           |  196 +++++
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |  457 ++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |   37 +
 arch/arm/mach-exynos/Kconfig                       |    2 +
 arch/arm/mach-exynos/common.c                      |   26 +
 drivers/gpio/gpio-samsung.c                        |   21 +
 drivers/pinctrl/Kconfig                            |    9 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/pinctrl-exynos.c                   |  560 ++++++++++++
 drivers/pinctrl/pinctrl-exynos.h                   |  217 +++++
 drivers/pinctrl/pinctrl-samsung.c                  |  888
++++++++++++++++++++
 drivers/pinctrl/pinctrl-samsung.h                  |  239 ++++++
 12 files changed, 2654 insertions(+), 0 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-exynos.c
 create mode 100644 drivers/pinctrl/pinctrl-exynos.h
 create mode 100644 drivers/pinctrl/pinctrl-samsung.c
 create mode 100644 drivers/pinctrl/pinctrl-samsung.h
