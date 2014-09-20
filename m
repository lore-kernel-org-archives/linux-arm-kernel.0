From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:06:33 +0200
Subject: [PATCH 0/3] sunxi: Add AXP209 regulator support
Message-ID: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie reworks a bit the MFD and regulator drivers for the AXP209
PMIC so that we rely purely on the DT and no longer on the regulator
aliases provided by the MFD driver.

It also enables the PMIC support for the Cubieboard2. Eventually,
other boards will follow.

Thanks!
Maxime

Maxime Ripard (3):
  regulator: axp20x: Use parent device as regulator configuration device
  mfd: axp209x: Drop the parent supplies field
  ARM: sun7i: cubieboard2: Enable the AXP209

 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 31 +++++++++++++++++++++++++++++
 drivers/mfd/axp20x.c                        | 11 ----------
 drivers/regulator/axp20x-regulator.c        |  2 +-
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.1.0
