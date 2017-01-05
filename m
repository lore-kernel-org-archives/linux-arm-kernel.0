From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Thu, 05 Jan 2017 17:27:09 +0900
Subject: [PATCH v2 0/4] Add touch key driver support for TM2
References: <CGME20170105082715epcas1p10e0820a792ba9d89cd165299d6602654@epcas1p1.samsung.com>
Message-ID: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the tm2 touchkey device.

The driver has been ported from Tizen Kernel, originally written
by Beomho. I ported it to the latest mainline Kernel.

The patchset applies on next-20170105.

Changes in v2:
 - fixed reviews from Javier, Dmitry
 - refactored power enable/disable functions.
 - reordered signed-offs in patch 2, while patch 4 is left as it
   was as Andi copy pasted the node to the new tm2.dts file
 - added Jarvier's (patch 1,2,4) and Krzysztof's (patch 4) reviews 
   and Rob's Ack
 - patch 3 diff has been generated with -B50%

Best Regards,
Jaechul

Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/samsung,tm2-touchkey.txt        |   27 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1116 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1105 +------------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tm2-touchkey.c              |  280 +++++
 7 files changed, 1445 insertions(+), 1097 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.7.4
