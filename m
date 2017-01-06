From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Fri, 06 Jan 2017 12:59:04 +0900
Subject: [PATCH v3 0/5] Add touch key driver support for TM2
References: <CGME20170106035913epcas5p2b7d66596e467c6169786eea56beb8ffc@epcas5p2.samsung.com>
Message-ID: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the tm2 touchkey device.

The driver has been ported from Tizen Kernel, originally written
by Beomho. I ported it to the latest mainline Kernel.

This patch need to apply after this one:
https://lkml.org/lkml/2016/12/29/319

Changes in v3:
 - Changed the commit ordering, the tm2-touchkey related patches
   are the last 3.
 - Added Chanwoo's patch which fixes the wrong voltage of ldo23
   and ldo25.
 - Andi (patch 3) moves the ldo31 and ldo38 in the tm2 and tm2e
   files as they have different values.

Changes in v2:
 - fixed reviews from Javier, Dmitry
 - refactored power enable/disable functions.
 - reordered signed-offs in patch 2, while patch 4 is left as it
   was as Andi copy pasted the node to the new tm2.dts file
 - added Jarvier's (patch 1,2,4) and Krzysztof's (patch 4) reviews
   and Rob's Ack
 - patch 3 diff has been generated with -B50%


Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Chanwoo Choi (1):
  arm64: dts: exynos5433: TM2/E: Fix wrong information of ldo23 and
    ldo25

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/samsung,tm2-touchkey.txt        |   27 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1118 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1113 +------------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   32 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tm2-touchkey.c              |  280 +++++
 7 files changed, 1469 insertions(+), 1113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.7.4
