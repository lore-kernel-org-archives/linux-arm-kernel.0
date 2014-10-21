From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Oct 2014 13:23:13 +0200
Subject: [PATCH v2 0/4] regulator: max77686/trats2: Disable some regulators in
 suspend
Message-ID: <1413890597-31037-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Changes since v1
================
1. Add patch 1/4 and 3/4.
2. Patch 2/4: Extend existing set_suspend_disable (for bucks) with
   LDO support. Implement set_suspend_enable. Suggested by Javier.
3. Patch 4/4: Add regulator suspend properties only to regulators
   actually supporting this. Other regulators, not implementing
   suspend enable/disable, will warn ("VCC_1.8V_IO: No configuration").
4. Patch 4/4: In suspend enable VHSIC_1.0V and VHSIC_1.8V regulators.
   Suggested by Chanwoo Choi.


Description
===========
This patchset makes use of Javier Martinez Cainllas changes [1].
It allows disabling some of the regulators during suspend to RAM.

Javier's patchset is necessary only to test it.

[1] [PATCH v3 0/2] ARM: EXYNOS: Call regulator suspend prepare/finish
    https://lkml.org/lkml/2014/10/20/545


Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  regulator: max77686: Replace hard-coded opmode values with defines
  regulator: max77686: Implement suspend disable for some LDOs
  mfd/regulator: dt-bindings: max77686: Document regulators off in
    suspend
  ARM: dts: exynos4412-trats: Add suspend configuration for max77686
    regulators

 Documentation/devicetree/bindings/mfd/max77686.txt |  6 ++
 arch/arm/boot/dts/exynos4412-trats2.dts            | 72 +++++++++++++---------
 drivers/regulator/max77686.c                       | 58 +++++++++++++----
 3 files changed, 94 insertions(+), 42 deletions(-)

-- 
1.9.1
