From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 16:03:38 +0100
Subject: [PATCH 0/8] regulator: max77686: Add GPIO control
Message-ID: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This patch helps in proper description of max77686 regulators in DTS by
allowing to control them over GPIO. This allows removal of
fixed regulators from DTS which duplicate the description of hardware.

The first five patches are cleanups, including board support removal.

The whole patchset should be taken at once.

Patchset is rebased on next-20141023 AND:
1. ARM: EXYNOS: Call regulator suspend prepare/finish
   https://lkml.org/lkml/2014/10/20/545
2. regulator: max77686/trats2: Disable some regulators in suspend
   https://lkml.org/lkml/2014/10/27/280


Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  regulator: max77802: Remove support for board files
  regulator: max77686: Remove support for board files
  mfd: max77686/802: Remove support for board files
  regulator: max77686: Make regulator_desc array const
  regulator: max77686: Initialize opmode explicitly to normal mode
  regulator: max77686: Add external GPIO control
  mfd/regulator: dt-bindings: max77686: Document gpio property
  ARM: dts: exynos4412-trats: Switch max77686 regulators to GPIO control

 Documentation/devicetree/bindings/mfd/max77686.txt |   3 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  25 +---
 drivers/mfd/max77686.c                             |  23 ---
 drivers/regulator/max77686.c                       | 158 +++++++++++++++------
 drivers/regulator/max77802.c                       |  44 ++----
 include/linux/mfd/max77686-private.h               |   1 -
 include/linux/mfd/max77686.h                       |  22 ---
 7 files changed, 141 insertions(+), 135 deletions(-)

-- 
1.9.1
