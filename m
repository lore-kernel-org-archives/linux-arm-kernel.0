From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Tue, 03 Jan 2017 16:57:13 +0900
Subject: [PATCH 0/4] Add touch key driver support for TM2
References: <CGME20170103075733epcas5p48985c789a816f1f2eae84c52e070cc14@epcas5p4.samsung.com>
Message-ID: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the tm2 touchkey device.

The driver has been ported from Tizen Kernel, originally written
by Beomho. I ported it to the latest mainline Kernel.

dts has been separated between tm2 and tm2e because touchkey is present in tm2
but not tm2e.

Best Regards,
Jaechul

Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/samsung,tm2-touchkey.txt        |   27 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1037 +------------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tm2-touchkey.c              |  326 ++++++
 7 files changed, 1422 insertions(+), 1028 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.7.4
