From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Oct 2014 10:25:10 +0200
Subject: [PATCH 0/2] regulator: max77686/trats2: Disable some regulators in
 suspend
Message-ID: <1413879912-26606-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset makes use of Javier Martinez Cainllas changes [1].
It allows disabling some of the regulators during suspend to RAM.

Javier's patchset is necessary only to test it.

[1] [PATCH v3 0/2] ARM: EXYNOS: Call regulator suspend prepare/finish
    https://lkml.org/lkml/2014/10/20/545

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  regulator: max77686: Implement suspend disable for some LDOs
  ARM: dts: exynos4412-trats: Add suspend configuration for max77686
    regulators

 arch/arm/boot/dts/exynos4412-trats2.dts | 135 +++++++++++++++++++++++++-------
 drivers/regulator/max77686.c            |  19 +++++
 2 files changed, 124 insertions(+), 30 deletions(-)

-- 
1.9.1
