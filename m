From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Tue, 17 Jan 2017 14:54:36 +0900
Subject: [PATCH v7 0/3] Add touch key driver support for TM2
References: <CGME20170117055443epcas1p40b08d361f8f95090ad7b4d855a5bfad4@epcas1p4.samsung.com>
Message-ID: <1484632479-3111-1-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch is last three patch from https://lkml.org/lkml/2017/1/6/277.
because 1 and 2 patches have already been merged by Krzysztof.

This patchset adds support for the tm2 touchkey device.

The driver has been ported from Tizen Kernel, originally written
by Beomho. I ported it to the latest mainline Kernel.

Best Regard,
Jaechul

Changes in v7
 - added Chanwoo's reviewed and tested.
 - fixed reviews from Dmitry.

Changes in v6:
 - changed compatible name from samsaung to cypress.
 - updated commit tags.
 - removed first two patches from the original patchset.

Changes in v5:
 - patch 1: removed a spurious regulator-always-off inherited from
   a different patch. Thanks Krzysztof.
 - patch 2: fixed a slip on  the model, thanks Javier (this patch
   confuses me quite a lot, this was all right some patches ago
   and re appeared on this one).
 - patch 2: removed 'regulator' label and used the original ldo3x
   labels. Krzysztof: it looks better indeed.
 - added Javier's reviews and Krzysztof's acks on the related
   patches.

Changes in v4:
 - patch 1 has been rebased on top of 7c294e002641 (arm64: dts:
   exynos: Remove unsupported regulator-always-off property from
   TM2E)
 - patch 2 has been generated with -B50% diff option using git
   2.11

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
 - added Jarvier's (patch 1,2,4) and Krzysztof's (patch 4)
   reviews
   and Rob's Ack
 - patch 3 diff has been generated with -B50%

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/cypress,tm2-touchkey.txt        |  27 ++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  13 +
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/tm2-touchkey.c              | 287 +++++++++++++++++++++
 5 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.7.4
